//
//  UploadVC.swift
//  AC-iOS-Final
//
//  Created by Richard Crichlow on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import AVFoundation

class UploadVC: UIViewController {

    let uploadView = UploadView()
    private let imagePickerVC = UIImagePickerController()
    private var currentSelectedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        imagePickerVC.delegate = self
        uploadView.postTextView.delegate = self
    }
    
    private func setupView() {
        view.addSubview(uploadView)
        // Set Title for VC in Nav Bar
        navigationItem.title = "New Post"
        // Set Right Bar Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "POST", style: .done, target: self, action: #selector(post))
        // Set Plus Button
        uploadView.plusSignButton.addTarget(self, action: #selector(addImageButton), for: .touchUpInside)
    }
    
    @objc private func addImageButton() {
        print("Open Image Library")
        let imageOptionAlert = Alert.create(withTitle: "Add An Image", andMessage: nil, withPreferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            Alert.addAction(withTitle: "Camera", style: .default, andHandler: { (_) in
                self.imagePickerVC.sourceType = .camera
                self.checkAVAuthorization()
            }, to: imageOptionAlert)
        }
        Alert.addAction(withTitle: "Photo Library", style: .default, andHandler: { (_) in
            self.imagePickerVC.sourceType = .photoLibrary
            self.checkAVAuthorization()
        }, to: imageOptionAlert)
        Alert.addAction(withTitle: "Cancel", style: .cancel, andHandler: nil, to: imageOptionAlert)
        self.present(imageOptionAlert, animated: true, completion: nil)
    }
    
    @objc private func post() {
        if currentReachabilityStatus == .notReachable {
            let noInternetAlert = Alert.createErrorAlert(withMessage: "No Internet Connectivity. Please check your network and restart the app.")
            self.present(noInternetAlert, animated: true, completion: nil)
            return
        }
        
        if let comment = uploadView.postTextView.text, !comment.isEmpty {
            if let image = uploadView.pickImageView.image {
                let currentUser = AuthUserService.manager.getCurrentUser()?.uid
                let postID = DatabaseService.manager.postsRef.childByAutoId().key
                let post = Post(postID: postID, imageURL: postID, comment: comment, userID: currentUser!)
                DatabaseService.manager.addPost(post, image)
                
            } else {
                //This triggers if user didn't put text in the backTextView
                let alert = Alert.createErrorAlert(withMessage: "Please pick an image.")
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            // This triggers if the user didn't put text in the frontTextView
            let alert = Alert.createErrorAlert(withMessage: "Please enter a comment.")
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func checkAVAuthorization() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .notDetermined:
            print("notDetermined")
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted) in
                if granted {
                    self.showImagePicker()
                } else {
                    self.deniedPhotoAlert()
                }
            })
        case .denied:
            print("denied")
            deniedPhotoAlert()
        case .authorized:
            print("authorized")
            showImagePicker()
        case .restricted:
            print("restricted")
        }
    }
    
    private func showImagePicker() {
        present(imagePickerVC, animated: true, completion: nil)
    }
    
    private func deniedPhotoAlert() {
        let settingsAlert = Alert.create(withTitle: "Please Allow Photo Access", andMessage: "This will allow you to share photos from your library and your camera.", withPreferredStyle: .alert)
        Alert.addAction(withTitle: "Cancel", style: .cancel, andHandler: nil, to: settingsAlert)
        Alert.addAction(withTitle: "Settings", style: .default, andHandler: { (_) in
            UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
        }, to: settingsAlert)
        self.present(settingsAlert, animated: true, completion: nil)
    }
}
extension UploadVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        //Make an empty string when someone starts typing
        
        textView.text = ""
        
    }
}
extension UploadVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { print("image is nil"); return }
        uploadView.pickImageView.image = image
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
