//
//  DataBaseService.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//
//service firebase.storage {
//    match /b/{bucket}/o {
//        match /{allPaths=**} {
//            allow read, write: if request.auth != null;
//        }
//    }
//}

import Foundation
import FirebaseDatabase
enum DataBaseErrors: Error{

}
class DataBaseService{
    static let manager = DataBaseService()
    var dbRef: DatabaseReference
    var userRef: DatabaseReference
    var postsRef: DatabaseReference
    private init() {
        // reference to the root of the Firebase database
        dbRef = Database.database().reference()
        //Children reference of the dataBase
        userRef = dbRef.child("users")
        postsRef = dbRef.child("posts")
    }
    func getDataBaseRef()->DatabaseReference{return dbRef}
    func getUserRef()->DatabaseReference{return userRef}
    func getPostsRef()->DatabaseReference{return postsRef}
    
}
