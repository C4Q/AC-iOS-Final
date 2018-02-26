//
//  UserClient.swift
//  trenddit
//
//  Created by Masai Young on 1/29/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthClient: NSObject {
    
    weak var delegate: AuthDelegate!
    
    static var currentUser: User? {
        return Auth.auth().currentUser
    }
    
    static var signedIn: Bool {
        if let _ = Auth.auth().currentUser {
            return true
        } else {
            return false
        }
    }
    
    func createUser(withEmail: String, password: String, displayName: String?) {
        Auth.auth().createUser(withEmail: withEmail, password: password) { [weak self] (user, error) in
            if let error = error {
                self?.delegate.handle(error: error)
            }
            
            if let createdUser = user {
                self?.delegate.didCreateUser?(user: createdUser)
            }
//            let changeRequest = user.createProfileChangeRequest()
//            guard let displayName = displayName else { return }
//
//            if let profileImage = image {
//                StorageService.manager.storeImage(image: profileImage, userId: user.uid, completion: { (imageURL) in
//                    changeRequest.photoURL = imageURL!
//                    changeRequest.displayName = displayName
//                    changeRequest.commitChanges(completion: { error in
//                        if let error = error {
//                            print(error.localizedDescription)
//                            return
//                        }
//                        self?.delegate.didCreateUser?(user: user)
//                        print("Added displayName: \(displayName) & photoURL \(AuthClient.currentUser?.photoURL?.absoluteString ?? "") to user: \(user.email ?? "No email")")
//                    })
//                })
//            }
            
            
            
        }
    }
    
    func signIn(withEmail: String, password: String) {
        Auth.auth().signIn(withEmail: withEmail, password: password) { [weak self]  (user, error) in
            if let error = error {
                self?.delegate.handle(error: error)
                self?.delegate.failedSignIn?(error: error)
            }
            
            if let user = user {
                self?.delegate.didSignIn?(user: user)
            }
        }
    }
    
    func signOut() {
        guard Auth.auth().currentUser != nil else { return }
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
    
    func sendPasswordReset(withEmail: String) {
        Auth.auth().sendPasswordReset(withEmail: withEmail) { (error) in
            
        }
    }
    
    func confirmPasswordReset(withCode: String, newPassword: String) {
        Auth.auth().confirmPasswordReset(withCode: withCode, newPassword: newPassword) { (error) in
            
        }
    }
    
}
