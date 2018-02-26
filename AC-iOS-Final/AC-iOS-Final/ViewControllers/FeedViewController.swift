//
//  FeedViewController.swift
//  AC-iOS-Final
//
//  Created by Reiaz Gafar on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import Kingfisher

class FeedViewController: UIViewController {

    // MARK: - Properties
    let feedView = FeedView()
    
    var posts = [Post]() {
        didSet {
            feedView.feedCollectionView.reloadData()
        }
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(feedView)
        feedView.feedCollectionView.dataSource = self
        feedView.feedCollectionView.delegate = self
        configureNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Do Firebase stuff
        FirebaseDatabaseManager.shared.observePosts(completionHandler: { (posts) in
            self.posts = posts
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Check for user
        if !FirebaseAuthManager.shared.isUserLoggedIn() {
            let loginVC = LoginViewController()
            present(loginVC, animated: true, completion: nil)
        }
    }

}

// MARK: - Nav bar
extension FeedViewController {
    private func configureNavBar() {
        navigationItem.title = "Home Feed"
    }
}

// MARK: - Collection view data source
extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! PostCollectionViewCell
        let post = posts[indexPath.row]
        cell.backgroundColor = .blue
        cell.postImageView.kf.indicatorType = .activity
        cell.postImageView.kf.setImage(with: URL(string: post.imgURL)!)
        cell.commentLabel.text = post.comment
        cell.setNeedsLayout()
        return cell
    }
    
}

// MARK: - Collection view delegate
extension FeedViewController: UICollectionViewDelegate {
    
}

// MARK: - Collection iew delegate flow layout
extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - (AppSettings.cellSpacing * 2)), height: (collectionView.bounds.height - (AppSettings.cellSpacing * 2)))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return AppSettings.cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return AppSettings.cellSpacing * 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: AppSettings.padding, left: AppSettings.padding, bottom: AppSettings.padding, right: AppSettings.padding)
    }
}
