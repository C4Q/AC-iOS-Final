//
//  UploadView.swift
//  AC-iOS-Final
//
//  Created by Reiaz Gafar on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import SnapKit

class UploadView: UIView {

    // MARK: - Properties
    lazy public var pickImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "camera_icon")
        return imageView
    }()
    
    lazy public var commentTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Add a comment..."
        textView.font = AppSettings.bodyFont
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
        return textView
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
extension UploadView {
    private func setupViews() {
        setupPickImageView()
        setupCommentTextView()
    }
    
    private func setupPickImageView() {
        addSubview(pickImageView)
        pickImageView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.40)
        }
    }
    
    private func setupCommentTextView() {
        addSubview(commentTextView)
        commentTextView.snp.makeConstraints { (make) in
            make.top.equalTo(pickImageView.snp.bottom).offset(AppSettings.padding)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(AppSettings.padding)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-AppSettings.padding)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-AppSettings.padding)
        }
    }
}
