//
//  PostTableViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import AVFoundation
import Toucan

class PostTableViewController: UITableViewController,UIGestureRecognizerDelegate {
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postComment: UITextView!
    
    private let imagePickerViewController = UIImagePickerController()
    private var currentSelectedImage: UIImage!
    
    @IBAction func uploadBarButtonAction(_ sender: UIBarButtonItem) {
        guard let user = AuthenticationService.manager.getCurrentUser(), let currentImage = currentSelectedImage else {
            let alertController = UIAlertController(title: "Plese allow access", message: nil, preferredStyle: .alert)
            let okAlertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAlertAction)
            present(alertController, animated: true, completion: nil)
            checkAVAuthorization()
            return
        }
        guard  postComment.text != "You can add your comment here" else{
            return
        }
        let newPost = Post(comment: postComment.text, userId: "\(user.uid)", postUId: "newUID", image: "newImage")
        DataBaseService.manager.addNewPost(newPost, user: user) { (error) in
            print(error)
        }
        FirebaseStorageManager.shared.storeImage(for: newPost, uid: newPost.postUId, image: currentImage)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestures()
        self.postComment.delegate = self
        self.imagePickerViewController.delegate = self
        addDoneButtonOnKeyboard()
        tableView.separatorColor = .clear
        postComment.layer.borderWidth = 1
        postComment.layer.cornerRadius = 5
    }
    
    
    func addGestures(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(setImageGesture(_:)))
        tap.delegate = self
        postImage.isUserInteractionEnabled = true
        postImage.addGestureRecognizer(tap)
    }
    
    @objc func setImageGesture(_ sender: UIGestureRecognizer){
        checkAVAuthorization()
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height * 0.5
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
}

//MARK: - PickerControllerDelegate
extension PostTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { print("image is nil"); return }
        // resize the image
        let sizeOfImage: CGSize = CGSize(width: 300, height: 300)
        let toucanImage = Toucan.Resize.resizeImage(image, size: sizeOfImage)
        currentSelectedImage = toucanImage
        self.postImage.image = currentSelectedImage
        self.postImage.contentMode = .scaleAspectFit
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
//MARK: - TextViewDelegate
extension PostTableViewController: UITextViewDelegate{
    func textViewDidEndEditing(_ textView: UITextView) {
        resignFirstResponder()
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == "You can add your comment here"{
            textView.text = ""
        }
        return true
    }
    //this function will add a done button since textFields doesn't resign on return
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        self.postComment.inputAccessoryView = doneToolbar
    }
    @objc func doneButtonAction()
    {
        postComment.resignFirstResponder()
        let point = CGPoint(x: 0, y: -50)
        tableView.setContentOffset(point, animated: false)
    }
}
