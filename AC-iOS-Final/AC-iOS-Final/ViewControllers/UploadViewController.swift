//
//  UploadViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import AVFoundation
import SVProgressHUD

class UploadViewController: UIViewController {

    let feedVC = FeedViewController()
    let invisibleViewController = UIViewController()
    
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
        SVProgressHUD.show()
        invisibleViewController.modalPresentationStyle = .overFullScreen
        present(invisibleViewController, animated: true, completion: nil)
        DBService.manager.addPost(comment: comment, image: image) { (didAddPost) in
            if didAddPost == true {
                let alert = UIAlertController(title: "Post Added", message: nil, preferredStyle: .alert)
                let action = UIAlertAction.init(title: "Ok", style: .default , handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                SVProgressHUD.dismiss()
                self.invisibleViewController.dismiss(animated: true, completion: nil)
            }
            else {
                let alert = UIAlertController(title: "Could not add post", message: nil, preferredStyle: .alert)
                let action = UIAlertAction.init(title: "Ok", style: .default , handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                SVProgressHUD.dismiss()
                self.invisibleViewController.dismiss(animated: true, completion: nil)
            }
        }
        //dismiss(animated: true, completion: nil)
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
        currentSelectedImage = image
        dismiss(animated: true, completion: nil)
    }

}
