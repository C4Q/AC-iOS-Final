//
//  PostTableViewCell.swift
//  AC-iOS-Final
//
//  Created by Luis Calle on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class PostTableViewCell: UITableViewCell {

    lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "placeholderImage")
        imageView.backgroundColor = UIColor.lightGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: "Post Cell")
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
    
    private func setupViews() {
        setupPostImageView()
        setupCommentLabel()
    }
    
    private func setupPostImageView() {
        addSubview(postImageView)
        postImageView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.width.equalTo(safeAreaLayoutGuide.snp.width)
            make.height.equalTo(postImageView.snp.width)
        }
    }
    
    private func setupCommentLabel() {
        addSubview(commentLabel)
        commentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(postImageView.snp.bottom).offset(4)
            make.leading.equalTo(safeAreaLayoutGuide).offset(8)
            make.bottom.trailing.equalTo(safeAreaLayoutGuide).offset(-8)
        }
    }
    
    public func configureCell(post: Post) {
        styleCell()
        postImageView.kf.indicatorType = .activity
        commentLabel.text = post.comment
        postImageView.kf.setImage(with: URL(string: post.postImageURL), placeholder: #imageLiteral(resourceName: "placeholderImage"), options: nil, progressBlock: nil) { (image, error, cache, url) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func styleCell() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width:0.0, height: 3.0)
        layer.shadowOpacity = 1.0
    }

}
