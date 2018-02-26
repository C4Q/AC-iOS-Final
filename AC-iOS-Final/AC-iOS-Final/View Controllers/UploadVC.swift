//
//  UploadVC.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import Photos
import MobileCoreServices
import AVFoundation
import IQKeyboardManagerSwift
import Toucan

class UploadVC: UIViewController {
    
    //UIObjects
    @IBOutlet weak var uploadImage: UIImageView!
    @IBOutlet weak var uploadComment: UITextField!
    @IBOutlet weak var doneButtonPressed: UIBarButtonItem!
    
    private let imagePickerView = UIImagePickerController()
    let currentUser = AuthUserManager.manager.getCurrentUser()
    var currentSelectedImage: UIImage!
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        imagePickerView.delegate = self
        
        //Mark: Adding Tap Gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openPhotoLibrary))
        uploadImage.isUserInteractionEnabled = true
        uploadImage.addGestureRecognizer(tapGesture)
    }
    
    
    //MARK: Pulling up the photo Library when image is tapped
    @objc private func openPhotoLibrary() {
        present(imagePickerView, animated: true, completion: nil)
    }
    
    private func showPhotoLibrary() {
        imagePickerView.sourceType = .photoLibrary
        checkAVAuthorization()
    }
    
    private func checkAVAuthorization() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .notDetermined:
            print("notDetermined")
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted) in
                if granted {
                    self.openPhotoLibrary()
                } else {
                    print("not granted")
                }
            })
        case .denied:
            print("denied")
        case .authorized:
            print("authorized")
            openPhotoLibrary()
        case .restricted:
            print("restricted")
        }
    }
    
    
    
    //MARK: done action will add photo to Firebase
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        
        if let image = currentSelectedImage {
            
            //TODO: add post to Firebase
            let childByAutoID = Database.database().reference(withPath: "posts").childByAutoId()//the autoID will the postUID
            let childKey = childByAutoID.key
            var post: Post
            post = Post(uid: childKey, userUID: (currentUser?.uid)!, comment: self.uploadComment.text!)
            
            
            FirebaseStorageManager.manager.storeImage(type: .post, uid: post.uid, image: image)
            print("image has been stored with\(post.uid)")
            //setting the value of the post
            childByAutoID.setValue((post.postToJSON())) { (error, dbRef) in
                if let error = error {
                    print("failed to add beer error: \(error)")
                    //failed Alert
                    self.setupPhotoUploadFailedAlert()
                } else {
                    print("post saved to dbRef: \(dbRef)")
                    //success alert
                    self.setupPhotoUploadedAlert()
                }
            }
        }
    }
    
    //MARK: Alerts for uploading photos
    func setupPhotoUploadedAlert(){
        let successAlert = UIAlertController(title: "Photo Uploaded", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Woohoo!", style: .default, handler: { (action) in
            //Present Tab Bar Controller
            let tabController = TabBarController.storyboardInstance()
            self.present(tabController, animated: true, completion: nil)
            print("you are now at the tab bar controller")
        })
        successAlert.addAction(okAction)
        self.present(successAlert, animated: true, completion: nil)
    }
    
    func setupPhotoUploadFailedAlert(){
        let successAlert = UIAlertController(title: "Upload Failed", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Bummer", style: .default, handler: nil)
        successAlert.addAction(okAction)
        self.present(successAlert, animated: true, completion: nil)
    }
}

//MARK: Configuring Photo Library
extension UploadVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { print("image is nil"); return }
        uploadImage.image = image
        
        //MARK: resize the image to be smaller
        let sizeOfImage: CGSize = CGSize(width: 200, height: 200)
        let toucanImage = Toucan.Resize.resizeImage(image, size: sizeOfImage)
        currentSelectedImage = toucanImage
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}








