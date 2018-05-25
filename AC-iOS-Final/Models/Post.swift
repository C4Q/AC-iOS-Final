//
//  Post.swift
//  AC-iOS-Final
//
//  Created by Luis Calle on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

struct Post {
    let userID: String
    let comment: String
    let postImageURL: String
    
    init(dict: [String : Any]) {
        userID = dict["userID"] as? String ?? ""
        comment = dict["comment"] as? String ?? ""
        postImageURL = dict["postImageURL"] as? String ?? ""
    }
}
