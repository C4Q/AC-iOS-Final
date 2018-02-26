//
//  UploadView.swift
//  AC-iOS-Final
//
//  Created by Luis Calle on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import SnapKit

class UploadView: UIView {
    
    lazy var newPostImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "camera_icon")
        imageView.contentMode = .center
        imageView.backgroundColor = UIColor.lightGray
        return imageView
    }()
    
    lazy var commentTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.lightGray
        textView.text = "Enter your comment here"
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 1/2
        textView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return textView
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
    
    private func setupViews() {
        setupNewPostImageView()
        setupCommentTextView()
    }
    
    private func setupNewPostImageView() {
        addSubview(newPostImageView)
        newPostImageView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.width.equalTo(safeAreaLayoutGuide.snp.width)
            make.height.equalTo(newPostImageView.snp.width)
        }
    }
    
    private func setupCommentTextView() {
        addSubview(commentTextView)
        commentTextView.snp.makeConstraints { (make) in
            make.top.equalTo(newPostImageView.snp.bottom).offset(8)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(8)
            make.bottom.trailing.equalTo(safeAreaLayoutGuide).offset(-8)
        }
    }

}
