//
//  StorageService.swift
//  AC-iOS-Final
//
//  Created by Luis Calle on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import FirebaseStorage

class StorageService {
    private init(){
        storage = Storage.storage()
        storageRef = storage.reference()
        postImagesRef = storageRef.child("postImages")
    }
    static let manager = StorageService()
    
    let firebaseAuthService = FirebaseAuthService()
    
    private var storage: Storage!
    private var storageRef: StorageReference!
    private var postImagesRef: StorageReference!
    
    public func getStorageRef() -> StorageReference { return storageRef }
    public func getPostImagesRef() -> StorageReference { return postImagesRef }
}
