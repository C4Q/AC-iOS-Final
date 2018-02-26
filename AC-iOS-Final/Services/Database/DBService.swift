//
//  DBService.swift
//  AC-iOS-Final
//
//  Created by Luis Calle on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import FirebaseDatabase

//
//  DBService.swift
//  FlashCardReview
//
//  Created by Luis Calle on 2/15/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DBService {

    private var dbRef: DatabaseReference!
    private var postsRef: DatabaseReference!
    
    
    private init(){
        dbRef = Database.database().reference()
        postsRef = dbRef.child("posts")
    }
    static let manager = DBService()
    
    public func formatDate(with date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, YYYY h:mm a"
        return dateFormatter.string(from: date)
    }
    
    public func getDB()-> DatabaseReference { return dbRef }
    public func getPosts()-> DatabaseReference { return postsRef }
}

