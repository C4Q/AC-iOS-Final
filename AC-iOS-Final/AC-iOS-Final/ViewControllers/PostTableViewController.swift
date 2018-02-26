//
//  PostTableViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class PostTableViewController: UITableViewController {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postComment: UITextView!
    
    @IBAction func uploadBarButtonAction(_ sender: UIBarButtonItem) {
        guard let user = AuthenticationService.manager.getCurrentUser() else {
            return
        }
        let newPost = Post(comment: "hey there this is the firstPost", userId: "\(user.uid)", postUId: "newUID")
        DataBaseService.manager.addNewPost(newPost, user: user) { (error) in
            print(error)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height * 0.5
    }

}
