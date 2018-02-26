//
//  UploadViewController.swift
//  AC-iOS-Final
//
//  Created by Reiaz Gafar on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import NotificationCenter
import AVFoundation

class UploadViewController: UIViewController {
    
    // MARK: - Properties
    let uploadView = UploadView()
    
    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(uploadView)
        configureNavBar()
        configureImageHandling()
        registerForKeyboardNotifications()
    }
    
}

// MARK: - Nav bar
extension UploadViewController {
    private func configureNavBar() {
        navigationItem.title = "Upload"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
    }
    
    @objc private func doneButtonTapped() {
        guard let image = uploadView.pickImageView.image else { return }
        guard let comment = uploadView.commentTextView.text else { return }
        
        // POST TO FIREBASE
        FirebaseDatabaseManager.shared.createPost(comment: comment, image: image)
    }
}

// MARK: - Configure image view
extension UploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // Add tap gesture recog to imageview
    func configureImageHandling() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(pickImageViewTapped))
        uploadView.pickImageView.addGestureRecognizer(tap)
        uploadView.pickImageView.isUserInteractionEnabled = true
    }
    
    @objc private func pickImageViewTapped() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // Gets image from photo lib and sets the imageview image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        uploadView.pickImageView.image = image
        dismiss(animated:true, completion: nil)
    }
}

// MARK: - Keyboard Handling
extension UploadViewController {
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    @objc private func keyboardWasShown(aNotification: NSNotification) {
        print("keyboard shown")
        let info: NSDictionary = aNotification.userInfo! as NSDictionary
        let kbSize = info.object(forKey: "UIKeyboardFrameEndUserInfoKey") as! CGRect
        print(kbSize)
        // Move view up by height
    }

    @objc private func keyboardWillBeHidden() {
        print("keyboard hidden")
        // Return view to normal
    }
}
