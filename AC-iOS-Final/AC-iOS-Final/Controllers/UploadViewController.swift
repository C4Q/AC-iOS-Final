//
//  UploadViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var feedPic: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    
    let picker = UIImagePickerController()
    
    //TODO: Set the tapGesture here:
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(feedPicTapped))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        commentTextView.delegate = self
        feedPic.addGestureRecognizer(tapGesture)
    }
    
    @objc func feedPicTapped() {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        self.present(picker, animated: true, completion: nil)
    }
    
    //MARK: - Picker Delegates
    /*These two methods handle our selections in the library and camera. We can either handle the cancel case with imagePickerControllerDidCancel or handle media with didFinishPickingMediaWithInfo*/
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        self.feedPic.contentMode = .scaleAspectFit //3
        self.feedPic.image = chosenImage //4
        self.dismiss(animated:true, completion: nil) //5
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        //TODO Upload pics to FB
        
        
        
        
        
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
        
        //dismiss the view???
    }
    
}


