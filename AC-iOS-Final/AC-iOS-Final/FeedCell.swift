//
//  FeedCell.swift
//  AC-iOS-Final
//
//  Created by Masai Young on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import Material
import SnapKit
import Kingfisher

class FeedCell: UITableViewCell {
    
    lazy var postImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .orange
        return iv
    }()
    lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    lazy var userLabel = UILabel()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.addArrangedSubview(userLabel)
        sv.addArrangedSubview(postImage)
        sv.addArrangedSubview(commentLabel)
        sv.axis = .vertical
        return sv
    }()
    
    
    public func configure(with post: Post) {
        userLabel.text = post.createdBy
        userLabel.font = UIFont(name: Stylesheet.Fonts.Bold, size: 20)
        
        commentLabel.text = post.comment
        commentLabel.font = UIFont(name: Stylesheet.Fonts.Light, size: 18)
        
        if let imageURL = post.imageURL {
            postImage.kf.setImage(with: URL(string: imageURL)!, placeholder: #imageLiteral(resourceName: "upload"))
            postImage.contentMode = .scaleToFill
            postImage.clipsToBounds = true
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func prepareViews() {
        self.addSubview(userLabel)
        self.addSubview(postImage)
        self.addSubview(commentLabel)
        prepareUserLabel()
        preparePostImage()
        prepareCommentLabel()
    }
    
    private func prepareUserLabel() {
        userLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(10)
            make.centerX.equalTo(snp.centerX)
        }
    }
    
    private func preparePostImage() {
        postImage.backgroundColor = .orange
        postImage.snp.makeConstraints { make in
            make.top.equalTo(userLabel.snp.bottom).offset(10)
            make.bottom.equalTo(commentLabel.snp.top).offset(-10)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.height.equalTo(snp.width)
            //            make.width.equalTo(snp.width)
            //            make.centerX.equalTo(snp.centerX)
        }
    }
    
    private func prepareCommentLabel() {
        commentLabel.snp.makeConstraints { make in
            make.bottom.equalTo(snp.bottom).offset(-10)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(snp.width).multipliedBy(0.8)
        }
    }
    
}
