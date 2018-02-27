//
//  FeedViewController.swift
//  
//
//  Created by C4Q on 2/26/18.
//

import UIKit
import FirebaseAuth
import Firebase
import Kingfisher

class FeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]() {
        didSet {
            tableView.reloadData()
        }
    }
  
    private var authUserService = AuthUserService()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        DBService.manager.getPosts().observe(.value) { (snapshot) in
            var posts = [Post]()
            for child in snapshot.children {
                let dataSnapshot = child as! DataSnapshot
                if let dict = dataSnapshot.value as? [String : Any] {
                    let post = Post.init(postDict: dict)
                    posts.append(post)
                }
            }
            self.posts = posts
        
        }

    }

    @IBAction func logOutPressed(_ sender: AnyObject) {
        do {
            try Auth.auth().signOut()
             performSegue(withIdentifier: "goToLogin" , sender: nil)
        }
        catch {
            print("error: there was a problem logging out")
        }
    }
    

}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Post Cell", for: indexPath) as! CustomCell
        let post = posts[indexPath.row]
        if let urlImage = post.imageURL {
            cell.postImage.kf.setImage(with: URL(string: urlImage)!, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        }
        cell.postComment.text = post.comment
       
        //cell.image.image =\
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
}

