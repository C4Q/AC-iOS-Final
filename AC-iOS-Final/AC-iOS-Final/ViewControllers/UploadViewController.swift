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
        uploadView.commentTextView.delegate = self
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
        uploadView.commentTextView.resignFirstResponder()
        // Post to firebase
        FirebaseDatabaseManager.shared.createPost(comment: comment, image: image, completionHandler: { (error) in
            if let error = error {
                self.presentAlertWith(title: "Error", message: error.localizedDescription)
            } else {
                self.presentAlertWith(title: "Success", message: "You have posted")
            }
            
        })
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

// MARK: - Text view delegate
extension UploadViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}

// MARK: - Keyboard Handling
extension UploadViewController {
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    @objc private func keyboardWasShown(aNotification: NSNotification) {
        let info: NSDictionary = aNotification.userInfo! as NSDictionary
        let kbSize = info.object(forKey: "UIKeyboardFrameEndUserInfoKey") as! CGRect
        // Move view up by height
        animateViewUp(by: kbSize.height)
    }

    @objc private func keyboardWillBeHidden() {
        // Return view to normal
        animateViewDown()
    }
    
    private func animateViewUp(by height: CGFloat) {
        UIView.animate(withDuration: 0.2) {
            self.view.transform = CGAffineTransform.init(translationX: 0, y: -(height - 60))
        }
    }
    
    private func animateViewDown() {
        UIView.animate(withDuration: 0.2) {
            self.view.transform = CGAffineTransform.identity
        }
    }
}
