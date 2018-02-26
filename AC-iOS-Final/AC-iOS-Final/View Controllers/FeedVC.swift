//
//  FeedVC.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import FirebaseStorage

class FeedVC: UIViewController {
    
    //UIObjects
    @IBOutlet weak var tableview: UITableView!
    
    var posts = [Post](){
        didSet{
            tableview.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor.orange
        self.navigationItem.title = "Meatly"
        tableview.estimatedRowHeight = 250
        tableview.rowHeight = UITableViewAutomaticDimension
        tableview.delegate = self
        tableview.dataSource = self
        //TODO: refresh delegate
        FirebasePostManager.manager.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(true)
        getPostsFromFirebase()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
    }

    
    //MARK: grabbing posts from Firebase
    func getPostsFromFirebase(){
        FirebasePostManager.manager.getAllPostsFromFirebase { (posts, error) in
            if let error = error{
                print("error getting all posts: \(error)")
            } else if let posts = posts{
                self.posts = posts
                print("you are getting posts")
                //tableview.reloadData()
            }
        }
    }
    
    //MARK: Log out Button Pressed
    @IBAction func signOutAction(_ sender: Any) {
        //sign out current user
        print("user signed out")
        AuthUserManager.manager.logout()
        dismiss(animated: true, completion: nil)
    }
}

//MARK: TableView Datasource
extension FeedVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let postCell = tableview.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as? FeedTableViewCell else {return UITableViewCell()}
        
        let post = posts[indexPath.row]
        
        postCell.commentLabel.text = "\(post.comment)"
       // if let imageURL = postCell.feedImage.image{
            //TODO: get image from Firebase Storage
            
            // Get a reference to the storage service using the default Firebase App
            let storage = Storage.storage()
            // Create a storage reference from our storage service
            let storageRef = storage.reference()
            // Create a child reference
            let imagesRef = storageRef.child("images/\(post.uid)")
            
            imagesRef.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
                if let error = error {
                    print(error)
                } else if let data = data {
                    postCell.feedImage?.image = UIImage(data: data)
                    postCell.setNeedsLayout()
                    postCell.setNeedsDisplay()
                    print("photo retrieved")
                    postCell.layoutIfNeeded()
                }
            }
            
//            let setFeedImageToUploadedImage: (UIImage) -> Void = {(uploadedImage: UIImage) in
//                postCell.feedImage.image = uploadedImage
//            }
//            FirebaseStorageManager.manager.retrieveImage(imageURL: imageURL,
//                                                         completionHandler: setFeedImageToUploadedImage,
//                                                         errorHandler: {print($0)})
//
       // }
        return postCell
    }
}


//MARK: TableView Delegate
extension FeedVC: UITableViewDelegate{
    
}

//MARK: Custom Delegate Extension
extension FeedVC: FirebasePostManagerDelegate{
    func addPost(_ userService: FirebasePostManager, postObject: Post) {
        tableview.reloadData()
        //call refresh delegate
    }
    
    func failedToAddPost(_ userService: FirebasePostManager, error: Error) {
        print("failed to add post with error: \(error.localizedDescription)")
    }
    
    func getPost(_ userService: FirebasePostManager, postObject: Post) {
        print("post retrieved from Firebase")
        //call refresh delegate
    }
    
    func failToGetPost(_ userService: FirebasePostManager, error: Error) {
        print("failed to get post with error: \(error.localizedDescription)")
    }
}
