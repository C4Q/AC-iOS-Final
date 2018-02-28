//
//  ViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q  on 2/22/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import ILLoginKit

class UploadVC: UIViewController {
    
    let contentView = UploadView()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(contentView)
        view.backgroundColor = .white
        navigationItem.title = "Upload Photo"
        navigationController?.navigationBar.barTintColor = Stylesheet.Colors.LightBlue
        setButtonActions()
    }
    
    // MARK: - User Actions
    @objc func openImagePicker() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func postPressed() {
        guard let image = contentView.addImgButton.imageView?.image else { return }
        let comment = contentView.createPostTV.text ?? "No comment for post!"
        DBService.manager.addPost(comment: comment, image: image) { (error) in
            if error == nil {
                self.createAlert(type: .success)
            } else {
                self.createAlert(type: .failure)
            }
        }
    }
    
    // MARK: - Setup - View/Data
    func setButtonActions() {
        contentView.addImgButton.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        contentView.postButton.addTarget(self, action: #selector(postPressed), for: .touchUpInside)
    }

}

private extension UploadVC {
    // Alert Controllers
    enum AlertReason {
        case success
        case failure
    }
    
    func createAlert(type: AlertReason) {
        var alertController: UIAlertController!
        let actions: [UIAlertAction]!
        switch type {
        case .success:
            alertController = UIAlertController(title: "Photo Uploaded!", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            actions = [okAction]
        case .failure:
            alertController = UIAlertController(title: "Upload Failed!", message: "DEV: Check console for error message.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            actions = [okAction]
        }
        actions.forEach({alertController.addAction($0)})
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension UploadVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var newImage: UIImage
        
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }
        
        contentView.addImgButton.setImage(newImage, for: .normal)
        contentView.addImgButton.alpha = 1.0
        dismiss(animated: true)
    }
}
