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
    
    lazy public var feedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: safeAreaLayoutGuide.layoutFrame, collectionViewLayout: layout)
        collectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: "postCell")
        return collectionView
    }()

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

extension FeedView {
    private func setupViews() {
        setupFeedCollectionView()
    }
    
    private func setupFeedCollectionView() {
        addSubview(feedCollectionView)
        feedCollectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(safeAreaLayoutGuide.snp.edges)
        }
    }
}
