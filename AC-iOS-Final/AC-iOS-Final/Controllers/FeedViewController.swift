//
//  FeedViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import Kingfisher


class FeedViewController: UITableViewController {
    
    @IBOutlet weak var signOutButton: UIBarButtonItem!

    var postsArray: [Post] = [Post]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: - LifeCycleMethods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier:"feedCell")
        
        //retrieveCommentsFromDatabase()
        configureTableView()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Firebase
        DatabaseManager.shared.observePosts(completionHandler: { (posts) in
            self.postsArray = posts
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Check for user
        if !AuthManager.shared.isUserLoggedIn() {
            let loginVC = LoginViewController()
            present(loginVC, animated: true, completion: nil)
        }
    }

    @IBAction func signOutTapped(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            let loginVC = LoginViewController()
            navigationController?.popToViewController(loginVC, animated: true)
        }
        catch {
            print("error signing out")
        }
    }

    //MARK: - Table View Set Up
    
    func configureTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 220//120.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
        let post = postsArray[indexPath.row]
        
        //Get image from storage
        cell.feedImage.kf.indicatorType = .activity
        cell.feedImage.kf.setImage(with: URL(string: post.imgURL)!, placeholder: #imageLiteral(resourceName: "Beach"), options: nil, progressBlock: nil) { (image, error, cacheType, url) in
            if let _ = image {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        
        //Get comment from database
        cell.feedComment.text = post.comment
        cell.selectionStyle = .none
        
        return cell
    }
    
    //For the cell resizing
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }

}



