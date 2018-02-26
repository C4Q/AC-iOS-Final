//
//  PostTableViewCell.swift
//  AC-iOS-Final
//
//  Created by Reiaz Gafar on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    // MARK: - Properties
    lazy public var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "camera_icon")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy public var commentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = ""
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    // MARK: - Inits
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
extension PostTableViewCell {
    private func setupViews() {
        setupCommentLabel()
        setupPostImageView()
    }
    
    private func setupCommentLabel() {
        addSubview(commentLabel)
        commentLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(snp.bottom)
            make.leading.equalTo(snp.leading).offset(AppSettings.padding)
            make.trailing.equalTo(snp.trailing).offset(AppSettings.padding)
        }
    }
    
    private func setupPostImageView() {
        addSubview(postImageView)
        postImageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(commentLabel.snp.top).offset(20)
            make.leading.equalTo(snp.leading)
            make.trailing.equalTo(snp.trailing)
            make.top.equalTo(snp.top)
        }
    }
    

}
