//
//  AuthenticationService.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import Firebase
enum AuthenticationServiceErrors: Error{
    case signInError
}
class AuthenticationService {
    private init(){}
    static let manager = AuthenticationService()
    //This function will get the current user
    func getCurrentUser()->User?{
        return Auth.auth().currentUser
    }
    //This function will create a new user
    func createUser(email: String, password: String, completion: @escaping (User)->Void, errorHandler: @escaping (Error)->Void){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error{
                //TODO  handle the error
                print("Dev: ",error)
                if let errCode = AuthErrorCode(rawValue: error._code) {
                    switch errCode {
                    case .emailAlreadyInUse:
                        print("invalid email")
                    case .weakPassword:
                        print("weak pass")
                    default:
                        print("Create User Error: \(error)")
                    }
                }
                errorHandler(error)
            }
            if let user = user{
                completion(user)
            }
        }
    }
    //this function will sign in using an email and password
    func signIn(email: String, password: String, completion: @escaping (User) -> Void, errorHandler: @escaping(Error)->Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                
                print("Dev: \(error)")
                errorHandler(AuthenticationServiceErrors.signInError)
            } else if let user = user {
                completion(user)
            }
        }
    }
    //this function will sign the user out
    func signout(errorHandler: @escaping(Error)->Void) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
            errorHandler(error)
        }
    }
    
}
