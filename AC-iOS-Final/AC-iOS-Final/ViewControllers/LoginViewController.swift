//
//  LoginViewController.swift
//  AC-iOS-Final
//
//  Created by Reiaz Gafar on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Properties
    let loginView = LoginView()
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginView)
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Button actions
    @objc private func loginButtonTapped() {
        guard let emailText = loginView.emailTextField.text else { return }
        guard let passwordText = loginView.passwordTextField.text else { return }
        guard !emailText.isEmpty else { presentAlertWith(title: "Error", message: "Please enter an email address"); return }
        guard !passwordText.isEmpty else { presentAlertWith(title: "Error", message: "Please enter a password"); return }

        FirebaseAuthManager.shared.login(email: emailText, password: passwordText) { (error) in
            if let error = error {
                self.presentAlertWith(title: "Error", message: error.localizedDescription)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc private func registerButtonTapped() {
        guard let emailText = loginView.emailTextField.text else { return }
        guard let passwordText = loginView.passwordTextField.text else { return }
        guard !emailText.isEmpty else { presentAlertWith(title: "Error", message: "Please enter an email address"); return }
        guard !passwordText.isEmpty else { presentAlertWith(title: "Error", message: "Please enter a password"); return }
        
        FirebaseAuthManager.shared.createAccount(email: emailText, password: passwordText) { (error) in
            if let error = error {
                self.presentAlertWith(title: "Error", message: error.localizedDescription)
            } else {
                self.presentAlertWith(title: "Success", message: "Account created. You can now log in.")
            }
        }
    }
    
}
