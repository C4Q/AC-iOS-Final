//
//  FirebaseDatabaseManager.swift
//  AC-iOS-Final
//
//  Created by Reiaz Gafar on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import FirebaseDatabase

class FirebaseDatabaseManager {
    static let shared = FirebaseDatabaseManager()
    private init() {
        self.dbRef = Database.database().reference()
        self.postRef = dbRef.child("posts")
    }
    
    let dbRef: DatabaseReference!
    let postRef: DatabaseReference!
    
    func createPost(comment: String, image: UIImage) {
        let child = postRef.childByAutoId()
        let post = Post(userID: FirebaseAuthManager.shared.getCurrentUser()!.uid, comment: comment)
        let postJSON = post.toJSON()
        child.setValue(postJSON)
        // ADD IMAGE TO STORAGE
        FirebaseStorageManager.shared.storeImage(uid: child.key, image: image)
    }
    
    
    
    func observePosts(completionHandler: @escaping ([Post]) -> Void,
                      errorHandler: @escaping (Error) -> Void) {
        let _ = postRef.observe(.value) { (snapshot) in
            print(snapshot)
        }
    }
    
}
