//
//  Posts.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

struct Posts {
    let comment: String
    let userID: String
    
    init(
         userID: String,
         comment: String) {
        self.userID = userID
        self.comment = comment
    }
    
    
}
