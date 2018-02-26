//
//  DBReference+Post.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import UIKit


extension DBService {
    public func addPost(comment: String, image: UIImage) {
        let childByAutoId = DBService.manager.getPosts().childByAutoId()
        //guard let userId = AuthUserService.getCurrentUser()?.uid else { fatalError("uid is nil")}
        childByAutoId.setValue(["postID"         : childByAutoId.key,
                                //"userId"        : userId,
                                "comment"         : comment]) { (error, dbRef) in
                                    if let error = error {
                                        print("addPost error: \(error)")
                                    } else {
                                        print("Post added to database reference: \(dbRef)")
                                        
                                        // add an image to storage
                                        StorageService.manager.storeImage(image: image, postID: childByAutoId.key)
                                        
                                        
                                    }
        }
    }
    
}

