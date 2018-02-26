//
//  LoginViewController.swift
//  AC-iOS-Final
//
//  Created by Reiaz Gafar on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginView)
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped() {
        
        guard let emailText = loginView.emailTextField.text else { return }
        guard let passwordText = loginView.passwordTextField.text else { return }
        guard !emailText.isEmpty else { return }
        guard !passwordText.isEmpty else { return }
        
        FirebaseAuthManager.shared.createAccount(email: emailText, password: passwordText) { (error) in
            if let error = error {
                self.presentAlertWith(title: "Error", message: error.localizedDescription)

            }
        }
        
        FirebaseAuthManager.shared.login(email: emailText, password: passwordText) { (error) in
            if let error = error {
                self.presentAlertWith(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    
    

}
