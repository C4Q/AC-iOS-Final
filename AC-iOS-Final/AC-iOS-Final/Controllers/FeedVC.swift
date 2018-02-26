//
//  FeedVC.swift
//  AC-iOS-Final
//
//  Created by Masai Young on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import Material
import SnapKit
import FirebaseAuth
import CodableFirebase

class FeedVC: UIViewController {
    
    let feedView = FeedView()
    let authClient = AuthClient()
    
    lazy var loginCoordinator: LoginCoordinator = {
        return LoginCoordinator(rootViewController: self)
    }()
    
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logOut))
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
    
    func showLogin() {
        loginCoordinator.start()
        loginCoordinator.authClient.delegate = self
    }
    
    @objc func logOut() {
        authClient.signOut()
        showLogin()
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
//        let post = Post(createdBy: "Sai", comment: "Comment", date: "Date", userID: "UID")
        let post = self.post[indexPath.row]
        cell.configure(with: post)
        return cell
    }
    
}

// MARK: Table View Delegate
extension FeedVC: UITableViewDelegate {
    
    // MARK: Cell Selection
    
    // MARK: Section Header Configuration
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
}

extension FeedVC: AuthDelegate {
    func didSignIn(user: User) {
        print("Signed in user \(user.email)")
        dismiss(animated: true, completion: nil)
    }
}
