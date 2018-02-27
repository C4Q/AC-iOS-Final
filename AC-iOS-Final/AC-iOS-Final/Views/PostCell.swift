//
//  PostCell.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

protocol PostCellDelegate: class {
    func postCellDeleteAction(_ postCell: PostCell, post: Post)
}

class PostCell: UICollectionViewCell {
    private var currentPost: Post!
    private var longPressGesture: UILongPressGestureRecognizer!
    
    public weak var delegate: PostCellDelegate?
    
    lazy var postComment: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    lazy var postImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage.init(named: "beauty")
        return iv
    }()
    
    lazy var postCreator: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 10.0
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(deleteAction))
        addGestureRecognizer(longPressGesture)
        setupViews()
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- Setup Views
extension PostCell {
    private func setupViews() {
        setupPostCreator()
        setupPostImage()
        setupPostComment()
    }
    
    private func setupPostComment() {
        let padding: CGFloat = 16
        addSubview(postComment)
        postComment.snp.makeConstraints { (make) in
            make.leading.equalTo(snp.leading).offset(padding)
            make.trailing.equalTo(snp.trailing).offset(-padding)
            make.bottom.equalTo(snp.bottom).offset(-padding)
        }
    }
    
    private func setupPostImage() {
        let padding: CGFloat = 16
        addSubview(postImage)
        postImage.snp.makeConstraints { (make) in
            make.top.equalTo(postCreator.snp.bottom).offset(padding)
            make.leading.equalTo(snp.leading).offset(padding)
            make.trailing.equalTo(snp.trailing).offset(-padding)
            make.bottom.equalTo(snp.bottom).offset(-padding * 2)
        }
    }
    
    private func setupPostCreator() {
        let padding: CGFloat = 16
        addSubview(postCreator)
        postCreator.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top).offset(padding)
            make.leading.equalTo(snp.leading).offset(padding)
            make.trailing.equalTo(snp.trailing).offset(-padding)
            
        }
    }
    
    public func configureCell(post: Post) {
        accessibilityLabel = postComment.text
        currentPost = post
        postComment.text = post.comment
        postCreator.text = "@\(post.creator)"
        if let imageURL = post.imageURL {
            postImage.kf.indicatorType = .activity
            postImage.kf.setImage(with: URL(string:imageURL), placeholder: UIImage.init(named: "beauty"), options: nil, progressBlock: nil) { (image, error, cacheType, url) in
            }
        }
    }
    
    @objc private func deleteAction() {
        if currentPost.userId != AuthUserService.getCurrentUser()?.uid { print("not post creator"); return }
        delegate?.postCellDeleteAction(self, post: currentPost)
    }
}

