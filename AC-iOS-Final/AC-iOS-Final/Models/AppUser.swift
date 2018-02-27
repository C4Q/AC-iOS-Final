//
//  AppUser.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import FirebaseAuth

class AppUser {
        let userID: String
        let username: String
    
        init(dict: [String : Any]) {
            userID = dict["userID"] as? String ?? ""
            username = dict["username"] as? String ?? ""
  
        }
}
