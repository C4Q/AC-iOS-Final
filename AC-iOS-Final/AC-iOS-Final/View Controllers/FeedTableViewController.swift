//
//  FeedTableViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import Firebase
import Kingfisher



class FeedTableViewController: UITableViewController {

   var posts = [Post]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    var user: AppUser?
    let currentUser = AuthUserService.getCurrentUser()
    var postsRef: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        loadData()
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    func loadData(){
        DBService.manager.getAllPosts { (allPosts) in
            self.posts = allPosts
        }
    }
    
    
    
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Log Out", message: "are you sure you want to log out?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
            AuthUserService.manager.signOut()
            self.present(LoginViewController.storyboardInstance(), animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedTableViewCell
        let postToSet = posts[indexPath.row]
        cell.feedCaption.text = postToSet.caption
        let imgURL = postToSet.imageUrl
        let url = URL(string: imgURL)
        cell.feedPicture.kf.indicatorType = .activity
        cell.feedPicture.kf.setImage(with: url)
        return cell
    }
    
    

  
}
