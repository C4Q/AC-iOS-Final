//
//  UploadViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import ImagePicker

class UploadViewController: UIViewController {

    var images = [UIImage]() {
        didSet {
            pictureView.image = images.first
        }
    }
    
    var imagePickerController: ImagePickerController!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 1

    }

    
    override func viewWillDisappear(_ animated: Bool) {
        self.pictureView.image = nil
        self.captionView.text = ""
    }
    
    @IBOutlet weak var pictureView: UIImageView!
    
    @IBOutlet weak var captionView: UITextView!
    
    
    @IBAction func cameraPressed(_ sender: UIBarButtonItem) {
        self.images = []
        present(imagePickerController, animated: true, completion: {
            self.imagePickerController.collapseGalleryView({
            })
        })
    }

    
    @IBAction func createPostPressed(_ sender: UIButton) {
        guard pictureView.image != nil else {
            let alertController = UIAlertController(title: "Picture Needed!", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
            }
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        guard !captionView.text.isEmpty else {
            let alertController = UIAlertController(title: "Caption Needed!", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
            }
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        if let currentUseruID = AuthUserService.getCurrentUser()?.uid {
            DBService.manager.newPost(caption: captionView.text!, uID: currentUseruID, image: pictureView.image)
        }
        
        let alertController = UIAlertController(title: "Success!", message: "post sucessful!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
            self.pictureView.image = nil
            self.captionView.text = ""
            self.resignFirstResponder()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
captionView.resignFirstResponder()
    }
    
    
}


extension UploadViewController: ImagePickerDelegate {
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        imagePicker.resetAssets()
        return
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        self.images = images
        dismiss(animated: true) {
            imagePicker.resetAssets()
        }
        return
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

