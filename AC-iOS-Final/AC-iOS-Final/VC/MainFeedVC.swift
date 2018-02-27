//
//  MainFeedVC.swift
//  AC-iOS-Final
//
//  Created by Richard Crichlow on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class MainFeedVC: UIViewController {
    
    let mainFeedView = MainFeedView()
    let emptyView = EmptyStateView(emptyText: "No posts.\nAdd a new post, or check your internet and restart the app.")
    
    // MARK: DataSource
    var postsArray = [Post]() {
        didSet {
            mainFeedView.tableView.reloadData()
            emptyView.removeFromSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        //TBV Delegates
        mainFeedView.tableView.delegate = self
        mainFeedView.tableView.dataSource = self
        mainFeedView.tableView.estimatedRowHeight = 150
        mainFeedView.tableView.rowHeight = UITableViewAutomaticDimension
        DatabaseService.manager.refreshDelegate = self
        DatabaseService.manager.showAlertDelegate = self
        refreshTableView()
    }
    
    private func setupView() {
        view.addSubview(mainFeedView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshTableView()
    }
    
    
    // TODO: Implement later?
    @objc func logOutButtonAction() {
        AuthUserService.manager.signOut()
        self.navigationController?.popToRootViewController(animated: true)
    }
}
extension MainFeedVC: UITableViewDelegate {
    
}
extension MainFeedVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! CustomTableViewCell
        
        let aPost = postsArray[indexPath.row]
        
        cell.configureCell(withPost: aPost)
        
        return cell
    }
    
    
}
extension MainFeedVC: ShowAlertDelegate {
    func showAlertDelegate(cardOrDeck: String) {
        let alert = Alert.create(withTitle: "Success", andMessage: "\(cardOrDeck) added!", withPreferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
extension MainFeedVC: RefreshDelegate {
    func refreshTableView() {
        DatabaseService.manager.getAllPosts(fromUserID: (AuthUserService.manager.getCurrentUser()?.uid)!) { (Posts) in
            if let posts = Posts {
                self.postsArray = posts
                
            } else {
                print("Couldn't get posts or there are no cards")
            }
        }
        if postsArray.isEmpty {
            self.view.addSubview(emptyView)
            
        } else {
            emptyView.removeFromSuperview()
        }
    }
}
