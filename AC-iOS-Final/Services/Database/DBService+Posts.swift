//
//  DBService+Posts.swift
//  AC-iOS-Final
//
//  Created by Luis Calle on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

extension DBService {
    public func addPost(postImage: UIImage, comment: String) {
        let childByAutoId = DBService.manager.getPosts().childByAutoId()
        childByAutoId.setValue(["userID"  : FirebaseAuthService.getCurrentUser()!.uid,
                                "comment" : comment]) { (error, dbRef) in
                                    if let error = error {
                                        print("addCategory error: \(error)")
                                    } else {
                                        print("category added @ database reference: \(dbRef)")
                                        StorageService.manager.storePostImage(postImage: postImage, postID: childByAutoId.key)
                                    }
        }
    }
    
    public func loadAllPosts(completionHandler: @escaping ([Post]?) -> Void) {
        let ref = DBService.manager.getPosts()
        ref.observe(.value) { (snapshot) in
            var allPosts = [Post]()
            for child in snapshot.children {
                let dataSnapshot = child as! DataSnapshot
                if let dict = dataSnapshot.value as? [String: Any] {
                    let post = Post.init(dict: dict)
                    allPosts.append(post)
                }
            }
            completionHandler(allPosts)
        }
    }
}
