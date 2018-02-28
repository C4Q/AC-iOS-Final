//
//  UploadView.swift
//  AC-iOS-Final
//
//  Created by Masai Young on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import SnapKit

final class UploadView: UIView {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "upload")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var addImgButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "upload"), for: .normal)
//        button.backgroundColor = .blue
        //button.setImage(#imageLiteral(resourceName: "photo-picker"), for: .normal)
        button.alpha = 0.15
        return button
    }()
    
    lazy var createPostTV: UITextView = {
        var tv = UITextView()
        tv.textColor = .black
        tv.layer.borderColor = Stylesheet.Colors.LightBlue.cgColor
        tv.layer.borderWidth = 2.0
        //TODO: How to make it wrap and limit charaters?
        return tv
    }()
    
    lazy var postButton: UIButton = {
        let button = UIButton()
        button.setTitle("POST", for: .normal)
        button.backgroundColor = Stylesheet.Colors.Blue
        button.setTitleShadowColor(.magenta, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    //Required Initializers
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setViews()
        backgroundColor = .white
    }
    
    //Constraining Objects using SnapKit
    func setViews(){
        setTextField()
        setAddImageButton()
        setPostButton()
    }
    
    private func setTextField() {
        addSubview(createPostTV)
        createPostTV.snp.makeConstraints{(make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(self.snp.height).dividedBy(8)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    private func setAddImageButton() {
        addSubview(addImgButton)
        addImgButton.snp.makeConstraints{(make) in
            make.size.equalTo(self.snp.width).multipliedBy(0.9)
            make.centerX.equalTo(snp.centerX)
//            make.centerY.equalTo(snp.centerY).offset(-20)
            make.top.equalTo(createPostTV.snp.bottom).offset(20)
        }
    }
    
    private func setPostButton() {
        addSubview(postButton)
        postButton.snp.makeConstraints{(make) in
            make.top.equalTo(addImgButton.snp.bottom).offset(20)
            make.width.equalTo(self.snp.width).multipliedBy(0.8)
            make.height.equalTo(self.snp.height).multipliedBy(0.05)//0.1
            make.centerX.equalTo(self.snp.centerX)
        }
    }
}
