//
//  Posts.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

struct Post: Codable {
    let userID: String
    let imgURL: String
    let comment: String
    
    func toJSON() -> Any {
        let jsonData = try! JSONEncoder().encode(self)
        return try! JSONSerialization.jsonObject(with: jsonData, options: [])
    }
}

//struct Posts {
//    let comment: String
//    let userID: String
//
//    init(
//         userID: String,
//         comment: String) {
//        self.userID = userID
//        self.comment = comment
//    }
//
//}

