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
    let postId: String
    let userId: String
    let comment: String
    let imageURL: String?
    let dateCreated: String
    let creator: String
    
    init(postDict: [String: Any]) {
        postId = postDict["postId"] as? String ?? ""
        userId = postDict["userId"] as? String ?? ""
        comment = postDict["comment"] as? String ?? ""
        imageURL = postDict["imageURL"] as? String ?? ""
        dateCreated = postDict["dateCreated"] as? String ?? ""
        creator = postDict["creator"] as? String ?? ""
    }
    
    init(snapshot: DataSnapshot) {
        postId = snapshot.childSnapshot(forPath: "postId").value as? String ?? ""
        userId = snapshot.childSnapshot(forPath: "userId").value as? String ?? ""
        comment = snapshot.childSnapshot(forPath: "comment").value as? String ?? ""
        imageURL = snapshot.childSnapshot(forPath: "imageURL").value as? String ?? ""
        dateCreated = snapshot.childSnapshot(forPath: "dateCreated").value as? String ?? ""
        creator = snapshot.childSnapshot(forPath: "creator").value as? String ?? ""
    }
}
