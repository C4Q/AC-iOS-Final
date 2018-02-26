//
//  Post.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//
import Foundation
import Firebase

class Post {
    let userId: String
    let comment: String
    let imageURL: String?
   
    
    init(postDict: [String : Any]) {
        userId = postDict["userId"] as? String ?? ""
        comment = postDict["comment"] as? String ?? ""
        imageURL = postDict["imageURL"] as? String ?? ""
    }
    
    init(snapshot: DataSnapshot) {
        userId = snapshot.childSnapshot(forPath: "userId").value as? String ?? ""
        comment = snapshot.childSnapshot(forPath: "comment").value as? String ?? ""
        imageURL = snapshot.childSnapshot(forPath: "imageURL").value as? String ?? ""
    }
}


