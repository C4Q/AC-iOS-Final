//
//  DBService+Comment.swift
//  trenddit
//
//  Created by Masai Young on 2/8/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import CodableFirebase

//extension DBService {
//    public func addSet(set: AliasGroup) {
//        guard let _ = AuthClient.currentUser else { return }
//        
//        let jsonData = try! FirebaseEncoder().encode(set)
//        
////        let aliasData = try! JSONEncoder().encode(set.alias.first!)
//        
//        dump(jsonData)
//        let params: [String: Any] = ["title"        : set.title,
//                                     "description"  : set.description,
//                                     "date"         : set.date,
//                                     "uid"          : set.uid,
//                                     "createdBy"    : set.createdBy,
//                                     "alias"        : NSArray(array: set.alias)]
//        DBService.manager.getSets().childByAutoId().setValue(jsonData) { (error, dbRef) in
//            if let error = error {
//                print("error adding set with error: \(error)")
//            } else {
//                print("added set successfully @ dbRef: \(dbRef)")
//            }
//        }
//    }
//    
//}

