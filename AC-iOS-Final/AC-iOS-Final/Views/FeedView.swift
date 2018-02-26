//
//  FeedView.swift
//  AC-iOS-Final
//
//  Created by Reiaz Gafar on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import SnapKit

class FeedView: UIView {
    
    // MARK: - Properties
    lazy public var feedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: safeAreaLayoutGuide.layoutFrame, collectionViewLayout: layout)
        collectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: "postCell")
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    lazy public var feedTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "postCell")
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
}

// MARK: - Autolayout
extension FeedView {
    private func setupViews() {
        //setupFeedCollectionView()
        setupFeedTableView()
    }
    
    private func setupFeedCollectionView() {
        addSubview(feedCollectionView)
        feedCollectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(safeAreaLayoutGuide.snp.edges)
        }
    }
    
    private func setupFeedTableView() {
        addSubview(feedTableView)
        feedTableView.estimatedRowHeight = 300
        feedTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(safeAreaLayoutGuide.snp.edges)
        }
    }
}
