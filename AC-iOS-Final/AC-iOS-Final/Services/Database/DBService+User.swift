//
//  DBService+User.swift
//  trenddit
//
//  Created by Masai Young on 2/7/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import FirebaseAuth

extension DBService {
    public func addUser() {
        guard let userId = AuthClient.currentUser?.uid else { fatalError("userId is nil") }
        guard let username = AuthClient.currentUser?.displayName else { fatalError("displayName is nil") }
        guard let email = AuthClient.currentUser?.email else { fatalError("email is nil") }
        let params: [String: Any] = ["userId"   : userId,
                                     "username" : username,
                                     "email"    : email]
        DBService.manager.getUsers().child(userId).setValue(params) { (error, dbRef) in
            if let error = error {
                print("error adding user with error: \(error)")
            } else {

                print("added user successfully @ dbRef: \(dbRef)")
            }
        }
    }
    
    public func addJobId(jobId: String, jobTitle: String, isCreator: Bool) {
        guard let userId = AuthClient.currentUser?.uid else { fatalError("userId is nil") }
        DBService.manager.getUsers().child("\(userId)/jobIds").updateChildValues([jobId : jobTitle])
    }
}
