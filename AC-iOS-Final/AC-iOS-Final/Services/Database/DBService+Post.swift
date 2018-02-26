//
//  DBService+Post.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import UIKit

extension DBService {
    public func addPost(comment: String, image: UIImage) {
        let childByAutoId = DBService.manager.getPosts().childByAutoId()
        let dateCreated = ISO8601DateFormatter().string(from: Date())
        guard let userId = AuthUserService.getCurrentUser()?.uid else {fatalError("uid is nil")}
        guard let displayName = AuthUserService.getCurrentUser()?.displayName else {fatalError("displayName is nil")}
        childByAutoId.setValue(["postId"        : childByAutoId.key,
                                "userId"        : userId,
                                "comment"       : comment,
                                "dateCreated"   : dateCreated,
                                "creator"       : displayName]) { (error, dbRef) in
                                    if let error = error {
                                        print("addPost error: \(error)")
                                    } else {
                                        print("post added to database reference: \(dbRef)")
//                                        add an image to storage
                                        
                                    }
                                    
        }
    }
}
