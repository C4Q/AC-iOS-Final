//
//  LoginView.swift
//  AC-iOS-Final
//
//  Created by Luis Calle on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    let loginContainerView = LoginContainerView()
    let signUpContainerView = SignUpContainerView()
    
    lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "meatly_logo")
        return imageView
    }()
    
    lazy var loginContainerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .groupTableViewBackground
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1/4
        return button
    }()
    
    lazy var signUpContainerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .groupTableViewBackground
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1/4
        return button
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
        setupLogoImage()
        setupLoginContainerButton()
        setupSignUpContainerButton()
        setupLoginContainerView()
        setupSignUpContainerView()

    }
    
    private func setupLogoImage() {
    addSubview(logoImage)
        logoImage.snp.makeConstraints { (make) in
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.3)
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
        }
    }
    
    private func setupLoginContainerButton() {
        addSubview(loginContainerButton)
        loginContainerButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.5)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
        }
    }
    
    private func setupSignUpContainerButton() {
        addSubview(signUpContainerButton)
        signUpContainerButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.5)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
        }
    }
    
    private func setupLoginContainerView() {
        addSubview(loginContainerView)
        loginContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(logoImage.snp.bottom)
            make.bottom.equalTo(loginContainerButton.snp.top)
            make.width.equalTo(safeAreaLayoutGuide.snp.width)
        }
    }
    
    private func setupSignUpContainerView() {
        addSubview(signUpContainerView)
        signUpContainerView.snp.makeConstraints { (make) in
            make.edges.equalTo(loginContainerView.snp.edges)
        }
    }
}

