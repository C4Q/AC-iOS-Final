//
//  Post.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import FirebaseDatabase

class Post: NSObject, Codable {
    let caption: String
    let uID: String
    let imageUrl: String
    
    init(caption: String, uID: String, imageUrl: String){
        self.caption = caption
        self.uID = uID
        self.imageUrl = imageUrl
    }
    
    init(caption: String, uID: String){
        self.caption = caption
        self.uID = uID
        self.imageUrl = ""
    }
    
}


