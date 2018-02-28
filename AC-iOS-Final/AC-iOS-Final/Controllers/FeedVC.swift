//
//  FeedVC.swift
//  AC-iOS-Final
//
//  Created by Masai Young on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import CodableFirebase

class FeedVC: UIViewController {
    
    let feedView = FeedView()
    let authClient = AuthClient()
    
    var post = [Post]() {
        didSet {
            feedView.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareContentView()
        view.backgroundColor = .white
        navigationItem.title = "Photo Feed"
        navigationController?.navigationBar.barTintColor = Stylesheet.Colors.LightBlue
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logOut))
        authClient.delegate = self
        self.feedView.tableView.dataSource = self
        self.feedView.tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DBService.manager.getPosts().observeSingleEvent(of: .value, with: { (snapshot) in
            guard let value = (snapshot.value as? NSDictionary)?.allValues else { return }
            do {
                let post = try FirebaseDecoder().decode([Post].self, from: value)
                self.post = post
                print(post)
            } catch let error {
                print(error)
            }
        })
    }
    
    @objc func logOut() {
        authClient.signOut()
        if let loginController = (self.parent?.currentTabBar?.parent as? TabBarVC)?.loginCoordinator {
            loginController.start()
        }
    }
    
    private func prepareContentView() {
         view.addSubview(feedView)
        feedView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
}

// MARK: Table View Data Source
extension FeedVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.post.count
    }
    
    // MARK: - Cell Rendering
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
        let post = self.post[indexPath.row]
        cell.configure(with: post)
        return cell
    }
    
}

// MARK: Table View Delegate
extension FeedVC: UITableViewDelegate {
    // MARK: Section Header Configuration
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
}

extension FeedVC: AuthDelegate {
    
}
