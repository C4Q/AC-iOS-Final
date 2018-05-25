//
//  UploadViewController.swift
//  AC-iOS-Final
//
//  Created by Luis Calle on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import SystemConfiguration

class UploadViewController: UIViewController {

    private let uploadView = UploadView()
    
    let imagePicker = UIImagePickerController()
    
    // https://stackoverflow.com/questions/35561977/how-do-i-make-a-keyboard-push-the-view-up-when-it-comes-on-screen-xcode-swift
    // reference for keyboard handling
    var keyboardAdjusted = false
    var lastKeyboardOffset: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(uploadView)
        imagePicker.delegate = self
        uploadView.commentTextView.delegate = self
        setupNavBar()
        setupNewPostImageViewGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if keyboardAdjusted == false {
            lastKeyboardOffset = getKeyboardHeight(notification: notification)
            view.frame.origin.y -= lastKeyboardOffset
            keyboardAdjusted = true
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if keyboardAdjusted == true {
            view.frame.origin.y += lastKeyboardOffset
            keyboardAdjusted = false
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    private func setupNavBar() {
        navigationItem.title = "Upload"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(post))
    }
    
    @objc private func post() {
        uploadView.commentTextView.resignFirstResponder()
        if !isInternetAvailable() {
            showAlert(title: "Upload Failed!", message: "No network connection available, please try again later")
            return
        }
        let imageToUpload = uploadView.newPostImageView.image
        var commentToAdd = uploadView.commentTextView.text
        if imageToUpload == #imageLiteral(resourceName: "camera_icon") {
            showAlert(title: "Upload Failed!", message: "Please select a photo to upload")
            return
        }
        if commentToAdd == nil || commentToAdd!.isEmpty || commentToAdd == "Enter your comment here"{
            commentToAdd = "No Comment"
        }
        DBService.manager.addPost(postImage: imageToUpload ?? #imageLiteral(resourceName: "placeholderImage"), comment: commentToAdd!)
        uploadView.newPostImageView.image = #imageLiteral(resourceName: "camera_icon")
        uploadView.newPostImageView.contentMode = .center
        uploadView.commentTextView.text = "Enter your comment here"
        uploadView.commentTextView.textColor = UIColor.lightGray
        showAlert(title: "Photo uploaded!", message: nil)
    }
    
    private func setupNewPostImageViewGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped(tapGestureRecognizer:)))
        uploadView.newPostImageView.isUserInteractionEnabled = true
        uploadView.newPostImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func profileImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let profileImageAlertController = UIAlertController(title: "Add Post Image", message: nil, preferredStyle: .alert)
        let fromCameraRollAction = UIAlertAction(title: "From camera roll", style: .default) { (alertAction) in
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let fromLaunchCameraAction = UIAlertAction(title: "Take a picture", style: .default) { (alertAction) in
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        profileImageAlertController.addAction(fromCameraRollAction)
        profileImageAlertController.addAction(fromLaunchCameraAction)
        profileImageAlertController.addAction(cancelAction)
        present(profileImageAlertController, animated: true, completion: nil)
    }

    private func showAlert(title: String, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) {alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // https://stackoverflow.com/questions/39558868/check-internet-connection-ios-10
    // reference to check if there is network connection or not
    func isInternetAvailable() -> Bool{
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
}

extension UploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let imageSelected = info[UIImagePickerControllerEditedImage] as? UIImage else {
            showAlert(title: "Error", message:  "Error selecting picture")
            return
        }
        uploadView.newPostImageView.contentMode = .scaleAspectFit
        uploadView.newPostImageView.image = imageSelected
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension UploadViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
}
