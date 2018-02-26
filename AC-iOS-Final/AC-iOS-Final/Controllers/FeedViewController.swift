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


class FeedViewController: UITableViewController {
    
    @IBOutlet weak var signOutButton: UIBarButtonItem!
    //declare instance variable here
    var postsArray: [Posts] = [Posts]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Register .xib file here:
        self.tableView.register(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier:"feedCell")
        
        
        
        retrieveCommentsFromDatabase()
        configureTableView()
        
        tableView.delegate = self
        tableView.dataSource = self
    
    }
    
    @IBAction func signOutTapped(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "login",
                         sender: self)
        }
            
        catch {
            print("error signing out")
        }
    }
    
    //MARK: - Table View Set Up
    
    func configureTableView() {
        tableView.reloadData()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
        let post = postsArray[indexPath.row]
        
        //TODO: Get image from storage
        //cell.feedImage.image =
        
        //TODO: Get comment from database
        cell.feedComment.text = post.comment
        cell.imageView?.image = UIImage(named: "beach")
        
        return cell
    }

    
    //MARK: Storage and Database setup
    
    func retrievePhotoLinksFromStorage() {
        
        
    }
    
    func retrieveCommentsFromDatabase() {
        let commentsDB = Database.database().reference().child("Posts")
        
        //ask Firebase to keep an eye out for any new messages added
        //closure gets called whenever a new item is added
        commentsDB.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! [String:String]
            
            //now we could use the value and tap into its strings by calling the key(s) you want
            let comment = snapshotValue["comment"]!
            let UID = snapshotValue["userID"]!
            
            print(comment, UID)
            //save the data we get back into a message object
            //create a new message object and set its properties to the text and sender that we get back from firebase
            let post = Posts(userID: UID, comment: comment)
            self.postsArray.append(post)
            
            self.configureTableView()
            self.tableView.reloadData()
            
            self.tableView.separatorStyle = .none
            
        }

}
    
}

