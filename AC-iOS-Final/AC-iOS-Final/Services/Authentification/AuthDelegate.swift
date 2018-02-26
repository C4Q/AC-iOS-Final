//
//  AuthDelegate.swift
//  trenddit
//
//  Created by Masai Young on 1/30/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import FirebaseAuth

@objc protocol AuthDelegate {
    @objc optional func didSignIn(user: User)
    @objc optional func failedSignIn(error: Error)
    
    @objc optional func didCreateUser(user: User)
    @objc optional func failedCreateUser(error: Error)
}

extension AuthDelegate {
    func handle(error: Error) {
        let nsError = error as NSError
        if let errorCode = AuthErrorCode(rawValue: nsError.code) {
            switch errorCode {
            case .emailAlreadyInUse:
                print("Email in use already.")
            case .invalidEmail:
                print("Email is invalid.")
            case .weakPassword:
                print("Password too weak \(nsError.userInfo["NSLocalizedFailureReasonErrorKey"]!)")
            case .wrongPassword:
                print("Wrong password")
            case .tooManyRequests:
                print("Too many request. Timed out.")
            case .userNotFound:
                print("User not found.")
            case .userDisabled:
                print("User disabled.")
            default:
                print("\(nsError.localizedDescription)")
            }
        }
    }
}
