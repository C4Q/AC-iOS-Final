//
//  Feed.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation


struct Post: Codable {
    let uid: String
    let userUID: String
    let comment: String
    func postToJSON() -> Any? {
        let jsonData = try! JSONEncoder().encode(self)
        return try! JSONSerialization.jsonObject(with: jsonData, options: [])
    }
}
