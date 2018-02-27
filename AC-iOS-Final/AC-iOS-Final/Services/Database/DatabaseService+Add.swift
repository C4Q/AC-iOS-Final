//
//  DatabaseService+Add.swift
//  AC-iOS-Final
//
//  Created by Richard Crichlow on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth

extension DatabaseService {
    
    /**
     Stores a UserProfile object in the database after account creation.
     
     - Parameter userProfile: The UserProfile object passed in.
     */
    public func addUserProfile(_ userProfile: UserProfile) {
        
        let ref = usersRef.child(userProfile.userID)
        
        ref.setValue(["email": userProfile.email,
                      "userID": userProfile.userID,
                      "displayName": userProfile.displayName
            
        ]) { (error, _) in
            if let error = error {
                self.delegate?.didFailAddingUserProfile?(self, error: error.localizedDescription)
                print("\(userProfile) not added to firebase")
            } else {
                print("new user added to database!!")
            }
        }
    }
    
    public func addPost(_ post: Post, _ image: UIImage?) {
        
        let ref = postsRef.child(post.userID).child(post.postID)
        
        ref.setValue(["imageURL": post.imageURL,
                      "postID": post.postID,
                      "comment": post.comment,
                      "userID": post.userID]) { (error, nil) in
                        if let error = error {
                            print(error)
                        } else {
                            print("Post Added")
                            self.refreshDelegate?.refreshTableView()
                            self.showAlertDelegate?.showAlertDelegate(cardOrDeck: "Post ")
                        }
        }
        StorageService.manager.storePostImage(image: image, withPostID: post.postID) { (errorMessage, _) in
            if let errorMessage = errorMessage {
                print(errorMessage)
            }
        }
    }
    
    public func addImageURLToPost(url: String, postID: String) {
        addImageURL(url: url, toRef: postsRef.child((AuthUserService.manager.getCurrentUser()?.uid)!), withID: postID)
    }
    
    private func addImageURL(url: String, toRef ref: DatabaseReference, withID id: String) {
        ref.child(id).child("imageURL").setValue(url)
        print("added image url")
    }
 
}
