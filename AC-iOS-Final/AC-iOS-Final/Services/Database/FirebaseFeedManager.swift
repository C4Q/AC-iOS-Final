//
//  FirebaseFeedManager.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import FirebaseDatabase

enum FirebasePostStatus: Error {
    case PostNotAdded
    case errorParsingPostData
    case PostDidNotUpdate
    case PostNotDeleted
}

protocol FirebasePostManagerDelegate: class {
    //Add beer protocols
    func addPost(_ userService: FirebasePostManager, postObject: Post)
    func failedToAddPost(_ userService: FirebasePostManager, error: Error)
    
    //Retrieve beer protocols
    func getPost(_ userService: FirebasePostManager, postObject: Post)
    func failToGetPost(_ userService: FirebasePostManager, error: Error)
    
    //Deleting beer protocols
//    func deletePost(_ userService: FirebasePostManager, withpostUID beerUID: String)
//    func failedToDeletePost(_ userService: FirebasePostManager, error: Error)
//    
}

//MARK: Automtically makes the functions optional without needing to have it conform to NSObject: Must have an implementation
extension FirebasePostManagerDelegate {
    
}

class FirebasePostManager {
    private init(){
        //root reference
        let dbRef = Database.database().reference()
        //child of the root
        postRef = dbRef.child("posts")
    }
    
    
    private var postRef: DatabaseReference!
    static let manager = FirebasePostManager()
    weak var delegate: FirebasePostManagerDelegate?
    
    //Add post to firebase..
//    public func addPostToFirebase(uid: String, userUID: String, comment: String, completion: @escaping (UIAlertController, Error?) -> Void){
//        //creating a unique key identifier
//        let childByAutoID = Database.database().reference(withPath: "post").childByAutoId()//the autoID will the beers name
//        let childKey = childByAutoID.key
//        var post: Post
//        post = Post(uid: childKey, userUID: userUID, comment: comment)
//        //setting the value of the post
//        childByAutoID.setValue((post.postToJSON())) { (error, dbRef) in
//            if let error = error {
//                self.delegate?.failedToAddPost(self, error: FirebasePostStatus.PostNotAdded)
//                print("failed to add beer error: \(error)")
//            } else {
//                self.delegate?.addPost(self, postObject: post)
//                //print("post saved to dbRef: \(dbRef)")
//            }
//        }
//    }
    
    //Gets ALL Posts
    func getAllPostsFromFirebase(completionHandler: @escaping ([Post]?, Error?) -> Void){
        // getting the reference for the node that is Posts
        let dbReference = Database.database().reference().child("posts")
        dbReference.observe(.value){(snapshot) in
            guard let snapshots = snapshot.children.allObjects as? [DataSnapshot] else {print("posts node has no children");return}
            var allPosts = [Post]()
            for snap in snapshots {
                //convert to json
                guard let rawJSON = snap.value else {continue}
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: rawJSON, options: [])
                    let post = try JSONDecoder().decode(Post.self, from: jsonData)
                    allPosts.append(post)
                    //print("post added to Post array")
                }catch{
                    print(error)
                }
            }
            completionHandler(allPosts, nil)
            
            //refactor with custom delegate methods
            if allPosts.isEmpty {
                print("There are no posts in the database")
            } else {
                print("posts loaded successfully!")
            }
        }
    }


}
