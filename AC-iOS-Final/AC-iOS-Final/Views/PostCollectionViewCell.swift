//
//  PostCollectionViewCell.swift
//  AC-iOS-Final
//
//  Created by Reiaz Gafar on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import SnapKit

class PostCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    lazy public var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .lightGray
        imageView.image = #imageLiteral(resourceName: "camera_icon")
        return imageView
    }()
    
    lazy public var commentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = ""
        label.textAlignment = .left
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    // MARK: - Inits
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
extension PostCollectionViewCell {
    private func setupViews() {
        setupPostImageView()
        setupCommentLabel()
    }
    
    private func setupPostImageView() {
        addSubview(postImageView)
        postImageView.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top)
            make.leading.equalTo(snp.leading)
            make.trailing.equalTo(snp.trailing)
        }
    }
    
    private func setupCommentLabel() {
        addSubview(commentLabel)
        commentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(postImageView.snp.bottom).offset(AppSettings.padding)
            make.leading.equalTo(snp.leading).offset(AppSettings.padding)
            make.trailing.equalTo(snp.trailing).offset(AppSettings.padding)
            make.bottom.equalTo(snp.bottom).offset(AppSettings.padding)
        }
    }
}
