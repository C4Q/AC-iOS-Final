//
//  DBService+Post.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//


import Foundation
import UIKit
import FirebaseDatabase

extension DBService {
    
    
    public func getAllPosts(completion: @escaping (_ posts: [Post]) -> Void) {
        postsRef.observe(.value) { (dataSnapshot) in
            var posts: [Post] = []
            guard let postSnapshots = dataSnapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            for postSnapshot in postSnapshots {
                guard let postObject = postSnapshot.value as? [String: Any] else {
                    return
                }
                guard let caption = postObject["caption"] as? String,
                    let uID = postObject["uID"] as? String,
                let imageURL = postObject["imageURL"] as? String
                else { print("error getting posts");return}
                
                let thisPost = Post(caption: caption, uID: uID, imageUrl: imageURL)
                posts.append(thisPost)
                
            }
            DBService.manager.posts = posts
            completion(posts)
        }
    }
    
 

    
    
    func newPost(caption: String, uID: String, image: UIImage?) {
        guard let currentUser = AuthUserService.getCurrentUser() else {print("could not get current user"); return}
        let ref = postsRef.childByAutoId()
        let post = Post(caption: caption, uID: currentUser.uid)
        ref.setValue(["caption": post.caption,
                      "uID": post.uID
            ])
        
        StorageService.manager.storePostImage(image: image, postID: ref.key) 
    }
    
    
    
    public func addImageToPost(url: String, postID: String) {
        addImage(url: url, ref: postsRef, id: postID)
    }
    
    
}


