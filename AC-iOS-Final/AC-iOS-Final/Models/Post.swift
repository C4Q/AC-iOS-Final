//
//  Post.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
class Post: Codable {
    var comment: String
    var userId: String
    var postUId: String
    func intoJSON() -> Any{
        let jsonData = try! JSONEncoder().encode(self)
        return try! JSONSerialization.jsonObject(with: jsonData, options: [])
    }
    init(comment: String, userId: String, postUId: String) {
        self.comment = comment
        self.userId = userId
        self.postUId = postUId
    }
}
