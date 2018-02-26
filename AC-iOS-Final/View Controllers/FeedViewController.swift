//
//  FeedViewController.swift
//  AC-iOS-Final
//
//  Created by Luis Calle on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    let feedView = FeedView()
    
    let firebaseAuthService = FirebaseAuthService()
    
    private var posts = [Post]() {
        didSet {
            DispatchQueue.main.async {
                self.feedView.postsTableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(feedView)
        firebaseAuthService.delegate = self
        feedView.postsTableView.delegate = self
        feedView.postsTableView.dataSource = self
        setupNavBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if FirebaseAuthService.getCurrentUser() == nil {
            let loginVC = LoginViewController()
            present(loginVC, animated: false, completion: nil)
        } else {
            DBService.manager.loadAllPosts(completionHandler: { (DBposts) in
                if let DBposts = DBposts { self.posts = DBposts }
                else { self.showAlert(title: "Error", message: "Could not load posts") }
            })
        }
    }

    private func setupNavBar() {
        navigationItem.title = "Feed"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
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
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension FeedViewController: FirebaseAuthServiceDelegate {
    func didSignOut(_ authService: FirebaseAuthService) {
        let loginVC = LoginViewController()
        self.present(loginVC, animated: true) {
            self.posts.removeAll()
            let tabBarController: UITabBarController = self.tabBarController! as UITabBarController
            tabBarController.selectedIndex = 0
        }
    }
    func didFailSigningOut(_ authService: FirebaseAuthService, error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
}

extension FeedViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if posts.count > 0 {
            feedView.postsTableView.backgroundView = nil
            feedView.postsTableView.separatorStyle = .singleLine
            numOfSections = 1
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: feedView.postsTableView.bounds.size.width, height: feedView.postsTableView.bounds.size.height))
            noDataLabel.text = "No Posts Yet!"
            noDataLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            noDataLabel.textAlignment = .center
            feedView.postsTableView.backgroundView = noDataLabel
            feedView.postsTableView.separatorStyle = .none
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postCell = tableView.dequeueReusableCell(withIdentifier: "Post Cell", for: indexPath) as! PostTableViewCell
        let selectedPost = posts.reversed()[indexPath.row]
        postCell.configureCell(post: selectedPost)
        return postCell
    }
    
    
}

extension FeedViewController: UITableViewDelegate { }
