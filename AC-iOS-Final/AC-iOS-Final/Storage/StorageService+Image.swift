//
//  StorageService+Image.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//


import Foundation
import UIKit
import FirebaseStorage
import Toucan

extension StorageService {
    public func storeImage(image: UIImage, postID: String, completion: @escaping (_ didStoreImage: Bool) -> Void) {
        guard let toucan = Toucan(image: image).resize(CGSize(width: 400, height: 400)).image else {return}
        guard let data = UIImageJPEGRepresentation(toucan, 1.0) else { print("image is nil"); return }
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        let uploadTask = StorageService.manager.getImagesRef().child(postID).putData(data, metadata: metadata) { (storageMetadata, error) in
            if let error = error {
                print("uploadTask error: \(error)")
            } else if let storageMetadata = storageMetadata {
                print("storageMetadata: \(storageMetadata)")
                let imageURL = storageMetadata.downloadURL()?.absoluteString
                DBService.manager.getPosts().child("\(postID)/imageURL").setValue(imageURL, withCompletionBlock: { (error, _) in
                    if let error = error {
                        print(error)
                        completion(false)
                    } else {
                        completion(true)
                    }
                })
            }
        }
        
//        // Listen for state changes, errors, and completion of the upload.
//        uploadTask.observe(.resume) { snapshot in
//            // Upload resumed, also fires when the upload starts
//        }
//
//        uploadTask.observe(.pause) { snapshot in
//            // Upload paused
//        }
//
//        uploadTask.observe(.progress) { snapshot in
//            // Upload reported progress
//            let percentProgress = 100.0 * Double(snapshot.progress!.completedUnitCount)
//                / Double(snapshot.progress!.totalUnitCount)
//            print(percentProgress)
//        }
        
//        uploadTask.observe(.success) { snapshot in
//            // Upload completed successfully
//
//            // set job's imageURL
//            let imageURL = String(describing: snapshot.metadata!.downloadURL()!)
//            DBService.manager.getPosts().child("\(postID)/imageURL").setValue(imageURL)
//
//            //DBService.manager.getJobs().child("\(jobId)").updateChildValues(["imageURL" :  imageURL])
//        }
        
        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error as NSError? {
                switch (StorageErrorCode(rawValue: error.code)!) {
                case .objectNotFound:
                    // File doesn't exist
                    break
                case .unauthorized:
                    // User doesn't have permission to access file
                    break
                case .cancelled:
                    // User canceled the upload
                    break
                    
                    /* ... */
                    
                case .unknown:
                    // Unknown error occurred, inspect the server response
                    break
                default:
                    // A separate error occurred. This is a good place to retry the upload.
                    break
                }
            }
        }
    }
}
