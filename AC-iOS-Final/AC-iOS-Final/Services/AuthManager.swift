//
//  AuthManager.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//


import Foundation
import FirebaseAuth

class AuthManager {
    static let shared = AuthManager()
    private init() {
        self.auth = Auth.auth()
    }
    
    let auth: Auth!
    
    func isUserLoggedIn() -> Bool {
        if let _ = auth.currentUser {
            return true
        } else {
            return false
        }
    }
    
    func getCurrentUser() -> User? {
        if let user = auth.currentUser {
            return user
        } else {
            return nil
        }
    }
    
    func createAccount(email: String, password: String, completion: @escaping (Error?) -> Void) {
        auth.createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                completion(error)
            } else if let _ = user {
                completion(nil)
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Error?) -> Void) {
        auth.signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                completion(error)
            } else if let _ = user {
                completion(nil)
            }
        }
    }
    
}
