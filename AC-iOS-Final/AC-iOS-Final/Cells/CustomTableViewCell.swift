//
//  CustomTableViewCell.swift
//  AC-iOS-Final
//
//  Created by Richard Crichlow on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class CustomTableViewCell: UITableViewCell {
    
    //userImageView - for user image
    lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = nil
        Stylesheet.Objects.ImageViews.Opaque.style(imageView: imageView)
        imageView.layer.borderWidth = CGFloat(Stylesheet.BorderWidths.FunctionButtons)
        return imageView
    }()
    
    //categoryLabel - for Post Category
    lazy var commentLabel: UILabel = {
        let ctv = UILabel()
        Stylesheet.Objects.Labels.Regular.style(label: ctv)
        return ctv
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        return activityIndicator
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: "PostCell")
        setupAndConstrainObjects()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupAndConstrainObjects()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor(red: 0.298, green: 0.278, blue: 0.247, alpha: 1.00)
        contentView.layer.borderColor = Stylesheet.Colors.LightGrey.cgColor
        contentView.layer.borderWidth = 3
        postImageView.layer.masksToBounds = true
        setupAndConstrainObjects()
    }
    
    public func configureCell(withPost post: Post) {
        self.commentLabel.text = "\(post.comment)"
        
        getImages(withPost: post)
    }
    
    private func getImages(withPost post: Post) {
        self.postImageView.image = nil
        //self.activityIndicator.startAnimating()
        guard post.imageURL != nil else {
            print("No image url")
            return
        }
        
        self.postImageView.image = nil
        self.activityIndicator.startAnimating()
        if let postURLString = post.imageURL, let imageURL = URL(string: postURLString) {
            ImageCache(name: post.postID).retrieveImage(forKey: post.postID, options: nil, completionHandler: { (image, _) in
                if let image = image {
                    self.postImageView.image = image
                    self.activityIndicator.stopAnimating()
                    self.layoutIfNeeded()
                } else {
                    self.postImageView.kf.setImage(with: imageURL, placeholder: #imageLiteral(resourceName: "NoDataAvailable"), options: nil, progressBlock: nil, completionHandler: { (image, error, _, _) in
                        if let image = image {
                            ImageCache(name: post.postID).store(image, forKey: post.postID)
                            self.activityIndicator.stopAnimating()
                            self.layoutIfNeeded()
                        }
                    })
                }
            })
        } else {
            self.postImageView.image = #imageLiteral(resourceName: "NoDataAvailable")
            self.activityIndicator.stopAnimating()
            self.layoutIfNeeded()
        }
    }
    
    private func setupAndConstrainObjects(){
        
        self.addSubview(postImageView)
        self.addSubview(commentLabel)
        self.addSubview(activityIndicator)
        
        postImageView.snp.makeConstraints { (make) -> Void in
            make.height.width.equalTo(self.snp.width).multipliedBy(1).priority(999)
            make.top.equalTo(self.snp.top).offset(5)
            make.leading.equalTo(self.snp.leading)
        }
        
        activityIndicator.snp.makeConstraints { (make) in
            make.edges.equalTo(postImageView)
        }
        
        commentLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(postImageView.snp.bottom).offset(5)
            make.leading.equalTo(self.snp.leading).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
        }
    }
}
