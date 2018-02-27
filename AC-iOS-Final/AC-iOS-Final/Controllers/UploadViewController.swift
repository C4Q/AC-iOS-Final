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

class UploadViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var feedPic: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        commentTextView.delegate = self
        configureFeedPicGesture()
    }
    
    @IBAction private func doneTapped(_ sender: UIBarButtonItem) {
            guard let image = feedPic.image else { return }
            guard let comment = commentTextView.text else { return }
            commentTextView.resignFirstResponder()
        
            // Post to firebase
            DatabaseManager.shared.createPost(comment: comment, image: image, completionHandler: { (error) in
                if let error = error {
                    self.showOKAlert(title: "Error", message: "error: \(error.localizedDescription)")
                } else {
                    self.showOKAlert(title: "Success", message: "You have posted")
                }
                
            })
        
        commentTextView.text = "Enter Comment Here..."
        
        }
    
    private func showOKAlert(title: String, message: String?, dismissCompletion: ((UIAlertAction) -> Void)? = nil, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: dismissCompletion)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: completion)
    }
    }

//MARK: -Image Picker setup
extension UploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Setup tap gesture recognizer for imageview
    func configureFeedPicGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(feedPicTapped))
        feedPic.addGestureRecognizer(tap)
        feedPic.isUserInteractionEnabled = true
    }
    
    @objc private func feedPicTapped() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.allowsEditing = false //true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // Get image from library + set new feedPic
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var newImage: UIImage
        
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }
        
        feedPic.image = newImage
        dismiss(animated: true)
        
//        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//        feedPic.contentMode = .scaleAspectFit
//        feedPic.image = chosenImage
//        dismiss(animated:true, completion: nil)
//        }
    }
}


