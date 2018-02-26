//
//  DBService+User.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import Firebase

extension DBService {
    
    public func addUser() {
        let user = DBService.manager.getUsers().child(AuthUserService.getCurrentUser()!.uid)
        user.setValue(["userID"     : AuthUserService.getCurrentUser()!.uid,
                       "username"   : AuthUserService.getCurrentUser()!.displayName! ]) { (error, dbRef) in
                        if let error = error {
                            print("addUser error: \(error.localizedDescription)")
                        } else {
                            print("user added @ database reference: \(dbRef)")
                        }
        }
    }
    
    public func addPostId(postId: String, comment: String, isCreator: Bool) {
        guard let userId = AuthUserService.getCurrentUser()?.uid else {fatalError("userId is nil")}
        DBService.manager.getUsers().child("\(userId)/postIds").updateChildValues([postId : comment])
    }
}
