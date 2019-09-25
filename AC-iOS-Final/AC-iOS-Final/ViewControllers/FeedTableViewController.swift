//
//  FeedTableViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import Kingfisher
class FeedTableViewController: UITableViewController {
    var posts = [Post](){
        didSet{
            tableView.reloadData()
            tableView.needsUpdateConstraints()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataBaseService.manager.retrieveAllPosts(completion: { [weak self](postsFromFireBase) in
            self?.posts = postsFromFireBase
        }, errorHandler: {print($0)})
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 250
    }


    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postSetup = posts[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as? FeedCustomTableViewCell else{
            return UITableViewCell()
        }
        // Configure the cell...
        cell.postComment.text = postSetup.comment
        FirebaseStorageManager.shared.retrieveImage(imgURL: postSetup.image, completionHandler: { (image) in
            cell.postImage.kf.indicatorType = .activity
            cell.postImage.image = image
            cell.setNeedsLayout()
        }) { (error) in
            print(error)
        }
        return cell
    }

}
// MARK: - Table view Delegate
extension FeedTableViewController{
//        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            return 150
//        }
}









