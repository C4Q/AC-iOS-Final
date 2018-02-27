//
//  Post.swift
//  AC-iOS-Final
//
//  Created by Richard Crichlow on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import UIKit

class Post: Codable {
    
    var postID: String
    var imageURL: String?
    var comment: String
    var userID: String
    
    init(postID: String, imageURL: String, comment: String, userID: String) {
        self.postID = postID
        self.imageURL = imageURL
        self.comment = comment
        self.userID = userID
        
    }
}
