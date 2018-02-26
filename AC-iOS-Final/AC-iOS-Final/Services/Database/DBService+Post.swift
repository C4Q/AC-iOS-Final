//
//  DBService+Post.swift
//  trenddit
//
//  Created by Masai Young on 2/7/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import CodableFirebase

extension DBService {
    public func addPost(comment: String, image: UIImage, then: @escaping (Error?) -> () ) {
        let dateCreated = ISO8601DateFormatter().string(from: Date())
        guard let currentUser = AuthClient.currentUser else { fatalError("not logged in")}
        guard let userId = AuthClient.currentUser?.uid else { fatalError("uid is nil")}
//        guard let displayName = AuthClient.currentUser?.displayName else { fatalError("displayName is nil") }
        
        let post = Post(userID: userId, comment: comment)
        let postData = try! FirebaseEncoder().encode(post)
        
        let childByAutoId = DBService.manager.getPosts().childByAutoId()
        childByAutoId.setValue(postData) { (error, dbRef) in
            then(error)
                                    if let error = error {
                                        print("add post error: \(error)")
                                    } else {
                                        print("post added to database reference: \(dbRef)")

                                        // add an image to storage
                                        StorageService.manager.storeImage(image: image, postId: childByAutoId.key)

                                        // TODO: add image to database

                                        // add job id to user
//                                        DBService.manager.addJobId(jobId: childByAutoId.key, jobTitle: title, isCreator: true)
                                    }
        }
    }

}

//["postID"         : childByAutoId.key,
// "userID"        : userId,
// "title"         : title,
// "creator"       : displayName,
// "userPhotoUrl"  : currentUser.photoURL?.absoluteString ?? "",
// "category"      : Array(category),
// "dateCreated"   : dateCreated,
// "upvotes"       : 0,
// "downvotes"     : 0,
// "totalVotes"    : 0,
// "flagged"       : false]
//
//
