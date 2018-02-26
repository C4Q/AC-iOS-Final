//
//  FeedViewController.swift
//  
//
//  Created by C4Q on 2/26/18.
//

import UIKit
import FirebaseAuth
import Firebase

class FeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Post] = []
    var user: User!
    
    let postReference = Database.database().reference(withPath: "posts")
    let usersReference = Database.database().reference(withPath: "online")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
        
        //cell.comment.text = post.comment
        //cell.image.image =\
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
}

