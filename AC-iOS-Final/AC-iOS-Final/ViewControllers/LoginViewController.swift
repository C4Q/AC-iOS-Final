//
//  ViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q  on 2/22/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import SVProgressHUD


class LoginViewController: UIViewController {

    let loginToFeed = "LoginToFeed"
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rootRef = Database.database().reference()
        let listener = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.performSegue(withIdentifier: self.loginToFeed, sender: nil)
            }
        }
        Auth.auth().removeStateDidChangeListener(listener)
    }

    
    @IBAction func LoginButtonPressed(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("login was successful")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: self.loginToFeed, sender: nil)
            }
        }
        
    }
    
    
    @IBAction func SignupButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Register",
                                      message: "Register",
                                      preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { action in
                                        let emailField = alert.textFields![0]
                                        let passwordField = alert.textFields![1]
                                        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!, completion: { (user, error) in
                                            if let error = error {
                                                if let errorCode = AuthErrorCode(rawValue: error._code) {
                                                    switch errorCode{
                                                    case .weakPassword:
                                                        print("Your password is weak, please chose a stronger password")
                                                    case .emailAlreadyInUse:
                                                        print("this email is already in use")
                                                    default:
                                                        print("error while creating an account")
                                                    }
                                                    
                                                }
                                            }
                                            if let user = user {
                                                user.sendEmailVerification(completion: { (error) in
                                                    print(error?.localizedDescription)
                                                })
                                                Auth.auth().signIn(withEmail: self.emailTextfield.text!, password: self.passwordTextfield.text!, completion: { (user, error) in
                                                    if let error = error {
                                                        print("trouble Signing in")
                                                    }
                                                     else {
                                                         self.performSegue(withIdentifier: self.loginToFeed, sender: nil)
                                                    }
                                                })
                                               
                                            }
                                        })
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
       
        
    }
    
    
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextfield {
            passwordTextfield.becomeFirstResponder()
        }
        if textField == passwordTextfield {
            textField.resignFirstResponder()
        }
        return true
    }
    
}






