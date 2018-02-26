//
//  PostFeedView.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import SnapKit

class PostsFeedView: UIView {

        lazy var collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            let cellSpacing: CGFloat = 10.0
            let itemWidth: CGFloat = bounds.width - (cellSpacing * 2)
            let itemHeight: CGFloat = bounds.height * 0.80
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = cellSpacing
            layout.minimumInteritemSpacing = cellSpacing
            layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
            layout.sectionInset = UIEdgeInsetsMake(cellSpacing, cellSpacing, cellSpacing, cellSpacing)
            let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
            cv.register(PostCell.self, forCellWithReuseIdentifier: "PostCell")
            cv.backgroundColor = .white
            return cv
        }()
        
        override init(frame: CGRect) {
            super.init(frame: UIScreen.main.bounds)
            setupViews()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }
    
    extension PostsFeedView {
        private func setupViews() {
            setupCollectionView()
        }
        
        private func setupCollectionView() {
            addSubview(collectionView)
            collectionView.snp.makeConstraints { (make) in
                make.edges.equalTo(self)
            }
        }
}

