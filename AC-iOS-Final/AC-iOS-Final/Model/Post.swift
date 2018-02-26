//
//  Post.swift
//  AC-iOS-Final
//
//  Created by Masai Young on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

struct Post: Codable {
    let createdBy: String
    let comment: String
    let date: String
    let userID: String
    let imageURL: String?
    
    
    init(userID: String, comment: String) {
        self.userID = userID
        self.comment = comment
        self.createdBy = AuthClient.currentUser!.email!
        self.date = Date().description
        self.imageURL = nil
    }
}
