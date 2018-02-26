//
//  PostCollectionViewCell.swift
//  AC-iOS-Final
//
//  Created by Reiaz Gafar on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    lazy public var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
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
        
    }
}
