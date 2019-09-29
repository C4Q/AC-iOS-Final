//
//  DBService.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//
import Foundation
import FirebaseDatabase

@objc protocol DBServiceDelegate: class {
    
    @objc optional func getPostsFromUsers(_ DBService:DBService, posts: [Post])
    
    @objc optional func didFailGettingUserPosts(_ databaseService: DBService, error: String)
 
    
    
    
}

class DBService: NSObject {
    
    private override init() {
        
        rootRef = Database.database().reference()
        usersRef = rootRef.child("users")
        postsRef = rootRef.child("posts")
        super.init()
        
    }
    
    static let manager = DBService()
    
    var posts = [Post]()
    
    
    var rootRef: DatabaseReference!
    var usersRef: DatabaseReference!
    var postsRef: DatabaseReference!
    var commentsRef: DatabaseReference!
    
    public weak var delegate: DBServiceDelegate?
    
    public func addImage(url: String, ref: DatabaseReference, id: String) {
        ref.child(id).child("imageURL").setValue(url)
        
    }
    
    
}
