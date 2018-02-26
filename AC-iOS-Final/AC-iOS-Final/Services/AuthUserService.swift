//
//  AuthUserService.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase

enum AuthUserStatus: Error {
    case failedToSignIn
    case didFailToVerifyEmail
    case failedToSignOut
    case failedToSendNewPassword
    case failedToCreateUser
}

protocol AuthUserDelegate: class {
    //create user delegate protocols
    func didFailCreatingUser(_ userService: AuthUserManager, error: Error)
    func didCreateUser(_ userService: AuthUserManager, user: User)
    
    //sign in delegate protocols
    func didFailToSignIn(_ userService: AuthUserManager, error: Error)
    func didSignIn(_ userService: AuthUserManager, user: User)
}

//MARK: Automtically makes the functions optional without needing to have it conform to NSObject: Must have an implementation
extension AuthUserDelegate {
    
}

//This API client is responsible for logging the user in and creating accounts in the Firebase database.
class AuthUserManager {
    private init(){
        //root reference
        let dbRef = Database.database().reference()
        //child reference
        usersRef = dbRef.child("users")
    }
    
    weak public var delegate: AuthUserDelegate!
    static let manager = AuthUserManager()
    private var usersRef: DatabaseReference!
    
    // Gets and returns the current user logged into Firebase as a User object.
    //The User object contains info about the user, like phone number, display name, email, etc.
    
    //Methods can also be called on this User object to do things like send email verification,reset password etc.
    
    func getCurrentUser() -> User? {
        if Auth.auth().currentUser != nil {
            print(Auth.auth().currentUser?.uid ?? "No current user")
            return Auth.auth().currentUser
        }
        return nil
    }
    
    
    //Creates an account for the user with their email and password.WORKS!
    public func createAccount(withEmail email: String, password: String){
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("Failure creating user with error: \(error)")
                self.delegate?.didFailCreatingUser(self, error: AuthUserStatus.failedToCreateUser)
            } else if let user = user {
                print(user.uid)
                //add email verification here later
                let child = self.usersRef.child(user.uid)
                child.observeSingleEvent(of: .value, with: {(dataSnapshot) in
                    //check to see if the username is already taken
                    guard !dataSnapshot.exists() else {print("\(user.uid) is already taken");return}
                })
                self.delegate?.didCreateUser(self, user: user)
                print("\(user.uid) added to firebase with email: \(email)")
                //add user to Firebase
                //self.addUserToFirebaseDatabase(userUID: user.uid, userName: userName)
            }
        }
    }
    
    
//    private func addUserToFirebaseDatabase(userUID: String, userName: String){
//        let userNameDatabaseReference = usersRef.child(userUID).child(userName)
//        //let childKey = userNameDatabaseReference.key
//        let user: UserProfile
//        user = UserProfile(userUID: userUID, userName: userName)
//        userNameDatabaseReference.setValue(user.userToJSON()) { (error, _) in
//            if let error = error {
//                print("User not added with error: \(error)")
//                self.delegate?.didFailCreatingUser(self, error: AuthUserStatus.failedToCreateUser)
//            }
//        }
//    }
//    
    
    //Logs the user in with their email and password.WORKS!
    public func login(withEmail email: String, andPassword password: String){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("failed to sign in with error: \(error)")
                self.delegate?.didFailToSignIn(self, error: AuthUserStatus.failedToSignIn)
            } else if let user = user {
                self.delegate?.didSignIn(self, user: user)
                //                if let email = user.email, let uid = user.uid{
                print("\(user.email, user.uid) logged in")
                print(Auth.auth().currentUser?.uid ?? "No ID login")
                //                }
            }
        }
    }
    
    //Signs the current user out of the app and Firebase.WORKS!
    public func logout(){
        do{
            try Auth.auth().signOut()
        } catch {
            print("failed to sign out with error: \(error)")
        }
    }
}


