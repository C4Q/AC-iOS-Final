//
//  AuthUserService.swift
//  
//
//  Created by C4Q on 2/26/18.
//

import Foundation
import Firebase
import SVProgressHUD


@objc protocol AuthUserServiceDelegate: class {
    
    //Create user delegate protocols
    @objc optional func didFailCreatingUser(_ userService: AuthUserService, error: Error)
    @objc optional func didCreateUser(_ userService: AuthUserService, user: AppUser)
    
    //Sign out delegate protocols
    @objc optional func didFailSigningOut(_ userService: AuthUserService, error: Error)
    @objc optional func didSignOut(_ userService: AuthUserService)
    
    //Sign in de()legate protocols
    @objc optional func didFailSigningIn(_ userService: AuthUserService, error: Error)
    @objc optional func didSignIn(_ userService: AuthUserService, user: AppUser)
    
    //email verification protocols
    @objc optional func didFailEmailVerification(_ authUserService: AuthUserService, user: User, error: String)
    @objc optional func didSendEmailVerification(_ authUserService: AuthUserService, user: User, message: String)
    
}


class AuthUserService: NSObject {
    private override init() {
        super.init()
        self.auth = Auth.auth()
    }
    static let manager = AuthUserService()
    
    
    weak public var delegate: AuthUserServiceDelegate?
    private var auth: Auth!
    public static func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    public func createUser(withEmail email: String, password pass: String) {
        Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
            if let error = error {
                self.delegate?.didFailCreatingUser?(self, error: error)
            } else if let user = user {
                
                let newAppUser = AppUser(email: email, uID: user.uid)
                DBService.manager.addAppUser(newAppUser)
                
                
                self.delegate?.didCreateUser?(self, user: newAppUser)
                // Update authentication user displayName with their email prefix
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = email
                changeRequest.commitChanges(completion: { (error) in
                    if let error = error {
                        print("changeRequest error: \(error.localizedDescription)")
                    } else {
                        self.delegate?.didCreateUser?(self, user: newAppUser)
                        print("changeRequest was successful")
                    }
                })
            }
        }
    }
    
    public func signOut() {
        do {
            try Auth.auth().signOut()
            delegate?.didSignOut?(self)
        } catch {
            delegate?.didFailSigningOut?(self, error: error)
        }
    }
    
    public func signIn(withEmail email: String, password pass: String) {
        Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
            if let error = error {
                SVProgressHUD.dismiss()
                self.delegate?.didFailSigningIn?(self, error: error)
            } else if let user = user {
                
                DBService.manager.getAppUser(with: user.uid, completion: { (AppUser) in
                    self.delegate?.didSignIn?(self, user: AppUser)
                })
            }
        }
    }
}
