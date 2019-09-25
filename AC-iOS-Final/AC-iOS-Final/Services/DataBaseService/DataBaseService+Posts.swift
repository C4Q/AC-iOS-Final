//
//  DataBaseService+Posts.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import Firebase
extension DataBaseService{
    //this function will retrieve all posts from the dataBas
    func retrieveAllPosts(completion: @escaping ([Post])->Void, errorHandler: @escaping (Error)->Void){
        let postRef = DataBaseService.manager.getPostsRef()
        postRef.observe(.value) { (snapshot) in
            guard let snapshots = snapshot.children.allObjects as? [DataSnapshot] else {return}
            var allPosts = [Post]()
            for snap in snapshots{
                guard let rawJSON = snap.value else{return}
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: rawJSON, options: [])
                    let post = try JSONDecoder().decode(Post.self, from: jsonData)
                    allPosts.append(post)
                }
                catch{
                    print(error)
                    errorHandler(error)
                }
            }
            completion(allPosts)
        }
    }
    func addNewPost(_ newPost: Post, user: User, errorHandle: (Error)->Void){
        let childByAutoId = self.getPostsRef().childByAutoId()
        newPost.postUId = childByAutoId.key
        childByAutoId.setValue(newPost.intoJSON())
    }
    
    
    
    
    
    
}









