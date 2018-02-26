//
//  DBService.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import FirebaseDatabase

class DBService {
    private init(){
        // reference to the root of the Firebase database
        dbRef = Database.database().reference()
        
        // children of root database node
        usersRef = dbRef.child("users")
        postRef = dbRef.child("post")
        imagesRef = dbRef.child("images")
        
    }
    static let manager = DBService()
    
    private var dbRef: DatabaseReference!
    private var usersRef: DatabaseReference!
    private var postRef: DatabaseReference!
    private var imagesRef: DatabaseReference!
   
    public func getDB()-> DatabaseReference { return dbRef }
    public func getUsers()-> DatabaseReference { return usersRef }
    public func getPosts()-> DatabaseReference { return postRef }
    public func getImages()-> DatabaseReference { return imagesRef }
}

