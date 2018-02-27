//
//  UploadView.swift
//  AC-iOS-Final
//
//  Created by Richard Crichlow on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import SnapKit

class UploadView: UIView {

    //ImageView for picking an Image
    lazy var pickImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = nil
        Stylesheet.Objects.ImageViews.Opaque.style(imageView: imageView)
        imageView.layer.borderWidth = CGFloat(Stylesheet.BorderWidths.FunctionButtons)
        imageView.layer.borderColor = (Stylesheet.Colors.Dark).cgColor
        return imageView
    }()
    
    //Label for Adding an Image
    lazy var addAnImageLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Add An Image:"
        Stylesheet.Objects.Labels.PostUsername.style(label: lb)
        return lb
    }()
    
    //Button that goes directly over addAnImage Label
    lazy var plusSignButton: UIButton = {
        let plusSign = UIButton()
        plusSign.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        Stylesheet.Objects.Buttons.ClearButton.style(button: plusSign)
        return plusSign
    }()
    
    //postTextView for PostText
    lazy var postTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Enter Post Text Here"
        Stylesheet.Objects.Textviews.Editable.style(textview: tv)
        tv.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .vertical)
        return tv
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
        backgroundColor = UIColor(red: 0.298, green: 0.278, blue: 0.247, alpha: 1.00)
        setupViews()
    }
    
    private func setupViews() {
        
        self.addSubview(pickImageView)
        self.addSubview(addAnImageLabel)
        self.addSubview(postTextView)
        self.addSubview(plusSignButton)
        
        pickImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width)
            make.height.equalTo(pickImageView.snp.width)
        }
        
        plusSignButton.snp.makeConstraints { (make) in
            make.center.equalTo(pickImageView.snp.center)
            make.edges.equalTo(pickImageView)
        }
        
        addAnImageLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.centerX.equalTo(pickImageView)
        }
        
        postTextView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(pickImageView.snp.bottom).offset(5)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }

}
