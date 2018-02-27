//
//  DatabaseManager.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase


class DatabaseManager {
    static let shared = DatabaseManager()
    private init() {
        self.dbRef = Database.database().reference()
        self.postRef = dbRef.child("posts")
    }
    
    let dbRef: DatabaseReference!
    let postRef: DatabaseReference!
    
    func createPost(comment: String,
                    image: UIImage,
                    completionHandler: @escaping (Error?) -> Void) {
        let child = postRef.childByAutoId()
        let post = Post(userID: AuthManager.shared.getCurrentUser()!.uid, imgURL: "", comment: comment)
        let postJSON = post.toJSON()
        child.setValue(postJSON)
        // Add image to storage
        StorageManager.shared.storeImage(uid: child.key, image: image, completionHandler: { (error) in
            if let error = error {
                completionHandler(error)
            } else {
                completionHandler(nil)
            }
        })
    }
    
    func observePosts(completionHandler: @escaping ([Post]) -> Void,
                      errorHandler: @escaping (Error) -> Void) {
        let _ = postRef.observe(.value) { (dataSnapshot) in
            var posts = [Post]()
            for child in dataSnapshot.children {
                let snapshot = child as! DataSnapshot
                if let data = snapshot.value  {
                    do {
                        let json = try JSONSerialization.data(withJSONObject: data, options: [])
                        let post = try JSONDecoder().decode(Post.self, from: json)
                        posts.append(post)
                    } catch {
                        errorHandler(error)
                    }
                }
                
            }
            completionHandler(posts)
        }
    }
    
}
