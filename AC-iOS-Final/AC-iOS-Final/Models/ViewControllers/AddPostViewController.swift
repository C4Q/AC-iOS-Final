//
//  AddPostViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import Toucan
import AVFoundation

class AddPostViewController: UIViewController {
    
    @IBOutlet weak var postComment: UITextField!
    @IBOutlet weak var photoLibraryButton: UIButton!
    @IBOutlet weak var postImage: UIImageView!
    
    private let imagePickerViewController = UIImagePickerController()
    
    private var currentSelectedImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
           imagePickerViewController.delegate = self

    }
    
    @IBAction func showPhotpLibrary(_sender: UIButton) {
        imagePickerViewController.sourceType = .photoLibrary
        checkAVAuthorization()
        photoLibraryButton.isHidden = true
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
                    print("not granted")
                }
            })
        case .denied:
            print("denied")
        case .authorized:
            print("authorized")
            showImagePicker()
        case .restricted:
            print("restricted")
        }
    }
   
    private func showImagePicker() {
        present(imagePickerViewController, animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        guard let image = currentSelectedImage else { print("don't have an image"); return }
        guard let comment = postComment.text else { print("title is nil"); return }
        guard !comment.isEmpty else { print("comment is empty"); return }
        DBService.manager.addPost(comment: comment, image: image)
        dismiss(animated: true, completion: nil)
    }
}

extension AddPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { print("image is nil"); return }
        postImage.image = image
        
        // resize the image
        let sizeOfImage: CGSize = CGSize(width: 200, height: 200)
        let toucanImage = Toucan.Resize.resizeImage(image, size: sizeOfImage)
        
        currentSelectedImage = toucanImage
        
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
