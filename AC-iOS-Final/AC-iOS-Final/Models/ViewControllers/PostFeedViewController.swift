//
//  PostViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import Firebase

class PostFeedViewController: UIViewController {

    let firebaseAuthService = AuthUserService()
    private let postsFeedView = PostsFeedView()
    
    private var posts = [Post]() {
        didSet {
            DispatchQueue.main.async {
                self.postsFeedView.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(postsFeedView)
        postsFeedView.collectionView.dataSource = self
        postsFeedView.collectionView.delegate = self
        setupNavBar()
        
        // get data from our "posts" reference
        DBService.manager.getPosts().observe(.value) { (snapshot) in
            var posts = [Post]()
            for child in snapshot.children {
                let dataSnapshot = child as! DataSnapshot
                if let dict = dataSnapshot.value as? [String : Any] {
                    let post = Post.init(postDict: dict)
                    posts.append(post)
                }
            }
            // filter out current user's job posts
            self.posts = posts.reversed()
//            self.posts = posts.filter{ $0.userId != AuthUserService.getCurrentUser()?.uid }
//                .sorted{ $0.dateCreated < $1.dateCreated }
        }
    }
    
   


    private func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Unit6Final-staGram"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.plain, target: self, action: #selector(logout))
    }
    
    @objc private func logout() {
        let alertView = UIAlertController(title: "Are you sure you want to logout?", message: nil, preferredStyle: .alert)
        let yesOption = UIAlertAction(title: "Yes", style: .destructive) { (alertAction) in
            self.firebaseAuthService.signOut()
        }
        let noOption = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alertView.addAction(yesOption)
        alertView.addAction(noOption)
        present(alertView, animated: true, completion: nil)
    }
    
    
//    //accessability
//    private func confirgureAccessability() {
//        navigationItem.rightBarButtonItem?.accessibilityLabel = "create new job"
//    }
//
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension PostFeedViewController: AuthUserServiceDelegate {
    
    func didSignOut(_ authService: AuthUserService) {
        self.dismiss(animated: true, completion: nil)
        print("heading to login")
        let loginController = LoginViewController.storyboardInstance()
        present(loginController, animated: true, completion: nil)
    }
    
    func didFailSigningOut(_ authService: AuthUserService, error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
}



extension PostFeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("there are \(posts.count) in the database")
        return posts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        cell.configureCell(post: post)
        cell.backgroundColor = .white
        return cell
    }
}

extension PostFeedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PostCell
        let post = posts[indexPath.row]
//        let detailVC = DetailViewController.storyboardInstance()
//        detailVC.job = job
//        detailVC.image = cell.jobImage.image
//        navigationController?.pushViewController(detailVC, animated: true)
    }
}
