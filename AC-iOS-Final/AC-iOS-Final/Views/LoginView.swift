//
//  LoginView.swift
//  AC-iOS-Final
//
//  Created by Reiaz Gafar on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import SnapKit

class LoginView: UIView {

    // Properties
    lazy public var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "meatly_logo")
        return imageView
    }()
    
    lazy public var emailTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.backgroundColor = .lightGray
        textField.placeholder = "Email"
        return textField
    }()
    
    lazy public var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.backgroundColor = .lightGray
        textField.placeholder = "Password"
        return textField
    }()
    
    lazy public var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("LOGIN / REGISTER", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    
    // Initializers
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

// Autolayout
extension LoginView {
    private func setupViews() {
        setupLogoImageView()
        setupEmailTextField()
        setupPasswordTextField()
        setupLoginButton()
    }
    
    private func setupLogoImageView() {
        addSubview(logoImageView)
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.30)
        }
    }
    
    private func setupEmailTextField() {
        addSubview(emailTextField)
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.75)
        }
    }
    
    private func setupPasswordTextField() {
        addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.75)
        }
    }
    
    private func setupLoginButton() {
        addSubview(loginButton)
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            //make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.75)
        }
    }
}
