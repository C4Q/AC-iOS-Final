//
//  FeedViewController.swift
//  AC-iOS-Final
//
//  Created by Reiaz Gafar on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    // MARK: - Properties
    let feedView = FeedView()
    
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(feedView)
        feedView.feedCollectionView.dataSource = self
        feedView.feedCollectionView.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Do Firebase stuff
        FirebaseDatabaseManager.shared
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

extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! PostCollectionViewCell
        cell.backgroundColor = .blue
        return cell
    }
    
}

extension FeedViewController: UICollectionViewDelegate {
    
}

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
