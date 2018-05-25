//
//  LoginViewController.swift
//  AC-iOS-Final
//
//  Created by Luis Calle on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    
    let firebaseAuthService = FirebaseAuthService()
    
    // https://stackoverflow.com/questions/35561977/how-do-i-make-a-keyboard-push-the-view-up-when-it-comes-on-screen-xcode-swift
    // reference for keyboard handling
    var keyboardAdjusted = false
    var lastKeyboardOffset: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.signUpContainerView.isHidden = true
        firebaseAuthService.delegate = self
        setTextFieldsDelegates()
        view.addSubview(loginView)
        setupButtonsActions()
    }
    
    private func setTextFieldsDelegates() {
        loginView.loginContainerView.emailLoginTextField.delegate = self
        loginView.loginContainerView.passwordTextField.delegate = self
        loginView.signUpContainerView.emailLoginTextField.delegate = self
        loginView.signUpContainerView.passwordTextField.delegate = self
        loginView.signUpContainerView.verifyPasswordTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if keyboardAdjusted == false {
            lastKeyboardOffset = getKeyboardHeight(notification: notification)
            view.frame.origin.y -= lastKeyboardOffset
            keyboardAdjusted = true
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if keyboardAdjusted == true {
            view.frame.origin.y += lastKeyboardOffset
            keyboardAdjusted = false
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    private func setupButtonsActions() {
        loginView.loginContainerButton.alpha = 1.0
        loginView.signUpContainerButton.alpha = 0.35
        loginView.loginContainerButton.addTarget(self, action: #selector(showLogin), for: .touchUpInside)
        loginView.signUpContainerButton.addTarget(self, action: #selector(showSignUp), for: .touchUpInside)
        loginView.signUpContainerView.signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        loginView.loginContainerView.loginButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        loginView.loginContainerView.forgotPasswordButton.addTarget(self, action: #selector(forgotPassword), for: .touchUpInside)
        
    }
    
    @objc private func showLogin() {
        loginView.signUpContainerView.isHidden = true
        loginView.loginContainerView.isHidden = false
        loginView.loginContainerButton.alpha = 1.0
        loginView.signUpContainerButton.alpha = 0.35
    }
    
    @objc private func showSignUp() {
        loginView.loginContainerView.isHidden = true
        loginView.signUpContainerView.isHidden = false
        loginView.signUpContainerButton.alpha = 1.0
        loginView.loginContainerButton.alpha = 0.35
    }
    
    @objc private func signUp() {
        view.endEditing(true)
        print("Sign up button pressed")
        if loginView.signUpContainerView.passwordTextField.text != loginView.signUpContainerView.verifyPasswordTextField.text {
            showAlert(title: "Error", message: "Passwords do not match")
            return
        }
        guard let emailText = loginView.signUpContainerView.emailLoginTextField.text else {
            showAlert(title: "Sign Up Failed!", message: "Please complete all fields")
            return
        }
        guard !emailText.isEmpty else {
            showAlert(title: "Sign Up Failed!", message: "Please complete all fields")
            return
        }
        guard let passwordText = loginView.signUpContainerView.passwordTextField.text else {
            showAlert(title: "Sign Up Failed!", message: "Please complete all fields")
            return
        }
        guard !passwordText.isEmpty else {
            showAlert(title: "Sign Up Failed!", message: "Please complete all fields")
            return
        }
        guard let verifyPasswordText = loginView.signUpContainerView.verifyPasswordTextField.text else {
            showAlert(title: "Sign Up Failed!", message: "Please complete all fields")
            return
        }
        guard !verifyPasswordText.isEmpty else {
            showAlert(title: "Sign Up Failed!", message: "Please complete all fields")
            return
        }
        firebaseAuthService.createUser(email: emailText, password: passwordText)
    }
    
    @objc private func signIn() {
        view.endEditing(true)
        guard let passwordText = loginView.loginContainerView.passwordTextField.text else {
            showAlert(title: "Login Failed!", message: "Please enter your password")
            return
        }
        guard !passwordText.isEmpty else {
            showAlert(title: "Login Failed!", message: "E-mail/Password field is empty")
            return
        }
        firebaseAuthService.signIn(email: loginView.loginContainerView.emailLoginTextField.text!, password: passwordText)
    }
    
    
    @objc private func forgotPassword() {
        let alertController = UIAlertController(title: "Reset Password", message: "Do you want to reset your password?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Reset", style: .destructive) { alert in
            self.firebaseAuthService.resetPassword(with: self.loginView.loginContainerView.emailLoginTextField.text!)
        }
        let noAction = UIAlertAction(title: "No", style: .default) { alert in }
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func showAlert(title: String, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) {alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func clearSignUpFields() {
        loginView.signUpContainerView.emailLoginTextField.text = ""
        loginView.signUpContainerView.passwordTextField.text = ""
        loginView.signUpContainerView.verifyPasswordTextField.text = ""
    }
    
}

extension LoginViewController: FirebaseAuthServiceDelegate {
    
    func didCreateUser(_ authService: FirebaseAuthService, user: User) {
        FirebaseAuthService.getCurrentUser()!.sendEmailVerification(completion: {(error) in
            if let error = error {
                print("Error sending email verification, \(error)")
                self.showAlert(title: "Error", message: "Error sending email verification")
                self.firebaseAuthService.signOut()
            } else {
                print("E-mail verification sent")
                self.showAlert(title: "Verification Sent", message: "Please verify email")
                self.showLogin()
                self.clearSignUpFields()
            }
        })
    }
    
    func didFailCreatingUser(_ authService: FirebaseAuthService, error: Error) {
        showAlert(title: "Sign Up Failed!", message: error.localizedDescription)
    }
    
    func didSignIn(_ authService: FirebaseAuthService, user: User) {
        if FirebaseAuthService.getCurrentUser()!.isEmailVerified {
            let signInAlertController = UIAlertController(title: "Login Successful!", message: nil, preferredStyle: .alert)
            let continueAction = UIAlertAction(title: "Continue", style: .default) {alert in
                self.dismiss(animated: true, completion: nil)
            }
            signInAlertController.addAction(continueAction)
            present(signInAlertController, animated: true, completion: nil)
        } else {
            showAlert(title: "E-mail Verification Needed", message: "Please verify e-mail")
            firebaseAuthService.signOut()
        }
    }
    
    func didFailSignIn(_ authService: FirebaseAuthService, error: Error) {
        showAlert(title: "Login Failed!", message: error.localizedDescription)
    }
    
    func didSendResetPassword(_ authService: FirebaseAuthService) {
        showAlert(title: "Password Reset", message: "Reset e-mail sent, check spam inbox!")
    }
    
    func didFailSendResetPassword(_ authService: FirebaseAuthService, error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
