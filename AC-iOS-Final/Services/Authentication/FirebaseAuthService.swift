//
//  FirebaseAuthService.swift
//  AC-iOS-Final
//
//  Created by Luis Calle on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import FirebaseAuth

@objc protocol FirebaseAuthServiceDelegate: class {
    // create user delegate protocols
    @objc optional func didFailCreatingUser(_ authService: FirebaseAuthService, error: Error)
    @objc optional func didCreateUser(_ authService: FirebaseAuthService, user: User)
    
    // sign in delegate protocols
    @objc optional func didFailSignIn(_ authService: FirebaseAuthService, error: Error)
    @objc optional func didSignIn(_ authService: FirebaseAuthService, user: User)
    
    // sign out delegate protocols
    @objc optional func didFailSigningOut(_ authService: FirebaseAuthService, error: Error)
    @objc optional func didSignOut(_ authService: FirebaseAuthService)
    
    // reset password delegate protocols
    @objc optional func didFailSendResetPassword(_ authService: FirebaseAuthService, error: Error)
    @objc optional func didSendResetPassword(_ authService: FirebaseAuthService)
}

class FirebaseAuthService: NSObject {
    
    weak var delegate: FirebaseAuthServiceDelegate?
    
    public static func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    public func createUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password){(user, error) in
            if let error = error {
                self.delegate?.didFailCreatingUser?(self, error: error)
            } else if let user = user {
                let changeRequest = user.createProfileChangeRequest()
                let stringArray = user.email!.components(separatedBy: "@")
                let username = stringArray[0]
                changeRequest.displayName = username
                changeRequest.commitChanges(completion: {(error) in
                    if let error = error {
                        print("changeRequest error: \(error)")
                    } else {
                        self.delegate?.didCreateUser?(self, user: user)
                    }
                })
            }
        }
    }

    
    public func resetPassword(with email: String) {
        Auth.auth().sendPasswordReset(withEmail: email){(error) in
            if let error = error {
                self.delegate?.didFailSendResetPassword?(self, error: error)
                return
            }
            self.delegate?.didSendResetPassword?(self)
        }
    }
    
    public func signOut() {
        do {
            try Auth.auth().signOut()
            delegate?.didSignOut?(self)
            print("Successfully signed out")
        } catch {
            delegate?.didFailSigningOut?(self, error: error)
        }
    }
    
    public func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {(user, error) in
            if let error = error {
                self.delegate?.didFailSignIn?(self, error: error)
            } else if let user = user {
                self.delegate?.didSignIn?(self, user: user)
            }
        }
    }
    
}
