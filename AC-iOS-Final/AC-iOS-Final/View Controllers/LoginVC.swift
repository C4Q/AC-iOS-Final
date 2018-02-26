//
//  LoginVC.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
    
    //UIObjects
    
    @IBOutlet weak var AppLogo: UIImageView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    let currentUser = AuthUserManager.manager.getCurrentUser()
    var activeTextField: UITextField?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        AuthUserManager.manager.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
    }
    
    //MARK: StoryBoard instance
    public static func storyboardInstance() -> LoginVC {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        return loginVC
    }
    
    //MARK: Login Button Pressed
    @IBAction func LoginButtonPressed(_ sender: UIButton) {
        guard let email = emailTF.text, let password = passwordTF.text else {print("textfield doesn't exist");return}
        guard !email.isEmpty, !password.isEmpty else {print("textfield is empty");return}
        //TODO: call login function
        AuthUserManager.manager.login(withEmail: email, andPassword: password)
    }
    
    //MARK: Register Button Pressed
    @IBAction func RegisterButtonPressed(_ sender: UIButton) {
        guard let email = emailTF.text, let password = passwordTF.text else {print("textfield doesn't exist");return}
        guard !email.isEmpty, !password.isEmpty else {print("textfield is empty");return}
        //TODO: call create user function
        AuthUserManager.manager.createAccount(withEmail: email, password: password)
        
        //good -> success controller and present tabbar controller
        //bad -> failed controller
    }
    
    //MARK: Alerts for Login
    func setupSuccessAlert(){
        let successAlert = UIAlertController(title: "Login Successful", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Woohoo!", style: .default, handler: { (action) in
            //Present Tab Bar Controller
            let tabController = TabBarController.storyboardInstance()
            self.present(tabController, animated: true, completion: nil)
            print("you are now at the tab bar controller")
        })
        successAlert.addAction(okAction)
        self.present(successAlert, animated: true, completion: nil)
    }
    
    func setupSuccessCreateUserAlert(){
        let successAlert = UIAlertController(title: "Restration Successful", message: "Login to begin sharing", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Woohoo!", style: .default, handler: nil)
        //        { (action) in
        //            //Present Tab Bar Controller
        //            let tabController = TabBarController.storyboardInstance()
        //            self.present(tabController, animated: true, completion: nil)
        //            print("you are now at the tab bar controller")
        //        })
        successAlert.addAction(okAction)
        self.present(successAlert, animated: true, completion: nil)
    }
    
    func setupFailureAlert(){
        let failureAlert = UIAlertController(title: "Login Failed", message: "Email or password is incorrect", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Bummer", style: .default, handler: nil)
        failureAlert.addAction(okAction)
        self.present(failureAlert, animated: true, completion: nil)
    }
    
    
}

extension LoginVC: AuthUserDelegate{
    
    func didFailCreatingUser(_ userService: AuthUserManager, error: Error) {
        if let user = currentUser {
            print("Failed create user: \(user.uid)")
        }
    }
    
    func didCreateUser(_ userService: AuthUserManager, user: User) {
        setupSuccessCreateUserAlert()
        print("successful creating user")
    }
    
    func didFailToSignIn(_ userService: AuthUserManager, error: Error) {
        setupFailureAlert()
        if let user = currentUser {
            print("Failed to sign in user: \(user.uid)")
        }
    }
    
    func didSignIn(_ userService: AuthUserManager, user: User) {
        setupSuccessAlert()
        print("successful sign-in")
    }
}

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
  
}


