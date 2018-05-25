//
//  LoginContainerView.swift
//  AC-iOS-Final
//
//  Created by Luis Calle on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import SnapKit

class LoginContainerView: UIView {
    
    lazy var emailAddressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.text = "e-mail"
        label.textAlignment = .right
        label.textColor = .black
        return label
    }()
    
    lazy var passwordAddressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .right
        label.text = "Password"
        label.textColor = .black
        return label
    }()
    
    lazy var emailLoginTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        textField.placeholder = "Enter e-mail address"
        textField.layer.cornerRadius = 5
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.textColor = .black
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        textField.placeholder = "Enter password"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.isSecureTextEntry = true
        textField.textColor = .black
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .groupTableViewBackground
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1/4
        return button
    }()
    
    lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot password?", for: .normal)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .clear
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
        setupPasswordTextField()
        setupPasswordAddressLabel()
        setupEmailAddressLabel()
        setupEmailLoginTextField()
        setupLoginButton()
        setupForgotPasswordButton()
    }
    
    private func setupPasswordTextField() {
        addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.7)
        }
    }
    
    private func setupPasswordAddressLabel() {
        addSubview(passwordAddressLabel)
        passwordAddressLabel.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(2)
            make.leading.equalTo(passwordTextField.snp.leading).offset(8)
        }
    }
    
    private func setupEmailAddressLabel() {
        addSubview(emailAddressLabel)
        emailAddressLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(passwordTextField.snp.top).offset(-8)
            make.leading.equalTo(passwordAddressLabel.snp.leading)
        }
    }
    
    private func setupEmailLoginTextField() {
        addSubview(emailLoginTextField)
        emailLoginTextField.snp.makeConstraints { (make) in
            make.bottom.equalTo(emailAddressLabel.snp.top).offset(-2)
            make.leading.equalTo(passwordTextField.snp.leading)
            make.width.equalTo(passwordTextField.snp.width)
        }
    }
    
    private func setupLoginButton() {
        addSubview(loginButton)
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordAddressLabel.snp.bottom).offset(10)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.3)
        }
    }
    
    private func setupForgotPasswordButton() {
        addSubview(forgotPasswordButton)
        forgotPasswordButton.snp.makeConstraints { (make) in
            make.top.equalTo(loginButton.snp.bottom).offset(4)
            make.centerX.equalTo(loginButton.snp.centerX)
            
        }
    }
    
}

