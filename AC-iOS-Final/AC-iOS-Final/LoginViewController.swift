//
//  LoginViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q  on 2/22/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    let firebaseAuthService = AuthUserService()
    private var tapGesture: UITapGestureRecognizer!
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseAuthService.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    public static func storyboardInstance() -> LoginViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        return loginViewController
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        print("Sign in button pressed")
        guard let passwordText = passwordTF.text else {
            print("password is nil")
            return
        }
        guard !passwordText.isEmpty else {
            print("Password field is empty")
            return
        }
        firebaseAuthService.signIn(email: emailTF.text!, password: passwordText)
    }
    
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        print("Sign up button pressed")
        guard let emailText = emailTF.text else {
            print("E-mail is nil")
            return
        }
        guard !emailText.isEmpty else {
            print("E-mail field is empty")
            return
        }
        guard let passwordText = passwordTF.text else {
            print("Password is nil")
            return
        }
        guard !passwordText.isEmpty else {
            print("Password field is empty")
            return
        }
        firebaseAuthService.createUser(email: emailText, password: passwordText)
    }
    
    private func showAlert(title: String, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) {alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func clearSignUpFields() {
        emailTF.text = ""
        passwordTF.text = ""
    }
}

extension LoginViewController: AuthUserServiceDelegate {
    
    func didCreateUser(_ userService: AuthUserService, user: User) {
        print("didCreateUser: \(user)")
        AuthUserService.getCurrentUser()?.sendEmailVerification(completion: { (error) in
            if let error = error {
                print("Error sending email verfication, \(error)")
                self.showAlert(title: "Error", message: "Error sending email verfication")
                self.firebaseAuthService.signOut()
            }
        })
    }
    
    func didFailCreatingUser(_ userService: AuthUserService, error: Error) {
         showAlert(title: error.localizedDescription, message: nil)
    }
    
    func didSignIn(_ userService: AuthUserService, user: User) {
        if AuthUserService.getCurrentUser()!.isEmailVerified {
            self.dismiss(animated: true, completion: nil)
        } else {
            showAlert(title: "E-mail Verification Needed", message: "Please verify e-mail")
            firebaseAuthService.signOut()
        }
        let tabController = TabBarController.storyboardInstance()
        present(tabController, animated: true, completion: nil)
    }
    
    func didFailSigningOut(_ userService: AuthUserService, error: Error) {
        showAlert(title: error.localizedDescription, message: nil)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
       
}
