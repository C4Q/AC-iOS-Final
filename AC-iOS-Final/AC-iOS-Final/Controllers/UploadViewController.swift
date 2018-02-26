//
//  UploadViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class UploadViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var feedPic: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet var picTapGesture: UITapGestureRecognizer!
    @IBOutlet weak var addImageButton: UIBarButtonItem!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        commentTextView.delegate = self
        
        //feedPic.addGestureRecognizer(tapGesture)
        
    }
    
    //MARK: -Image Picker setup
    @IBAction func addImageTapped(_ sender: UIBarButtonItem) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        feedPic.contentMode = .scaleAspectFit //3
        feedPic.image = chosenImage //4
        dismiss(animated:true, completion: nil) //5
        
        var data = Data()
        data = UIImageJPEGRepresentation(chosenImage, 0.8)!
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let imageRef = storageRef.child("images")
        
        _ = imageRef.putData(data, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            // Metadata contains file metadata such as size, content-type, and download URL.
            let downloadURL = metadata.downloadURL
            print(downloadURL)
            
            let key =  Database.database().reference().childByAutoId().key
            let image = ["url" : downloadURL()?.absoluteString]
            
            let childUpdates = ["\(key)" : image]
            
        }
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK: - Send data to storage and database

    
    func uploadCommentsToDB() {
        //TODO UPLOAD COMMENTS to FB
        let commentsDB = Database.database().reference().child("Posts")
        //save the users message as a dictionary
        let commentsDictionary = ["comment" : commentTextView.text,
                                  "userID" : Auth.auth().currentUser?.uid]
        
        commentsDB.childByAutoId().setValue(commentsDictionary) { (error, reference) in
            if error != nil {
                print(error!)
            } else {
                print("message saved successfully!")
                
            }
        }
    }

    
    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        uploadCommentsToDB()
        
        
    }
    
}

