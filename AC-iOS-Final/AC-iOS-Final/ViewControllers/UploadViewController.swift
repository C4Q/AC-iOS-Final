//
//  UploadViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import AVFoundation

class UploadViewController: UIViewController {

    let feedVC = FeedViewController()
    
    @IBOutlet weak var accessPhotoLibrary: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var comment: UITextView!
    
    private let imagePickerController = UIImagePickerController()
    
    private var currentSelectedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
    }
    
    @IBAction func showPhotoLibrary(_ sender: UIButton) {
        checkAVAuthorizationStatus()
        imagePickerController.sourceType = .photoLibrary
    }
    
    
    @IBAction func PostButton(_ sender: UIBarButtonItem) {
        guard let image = currentSelectedImage else { print("don't have an image"); return }
        guard let comment = comment.text else { print("title is nil"); return }
        guard !comment.isEmpty else { print("title is empty"); return }
        DBService.manager.addPost(comment: comment, image: image)
       // dismiss(animated: true, completion: nil)
    }
    
}
extension UploadViewController {
    private func checkAVAuthorizationStatus() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            print("authorized")
            showPickerController()
        case .denied:
            print("denied")
        case .restricted:
            print("restricted")
        case .notDetermined:
            print("nonDetermined")
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted) in
                if granted {
                    self.showPickerController()
                }
            })
        }
    }
    
    private func showPickerController() {
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
}
extension UploadViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {return}
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }

}
