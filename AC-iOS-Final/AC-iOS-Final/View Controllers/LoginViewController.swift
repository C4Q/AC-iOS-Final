//
//  ViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q  on 2/22/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        AuthUserService.manager.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
    }

 
    @IBAction func loginPressed(_ sender: UIButton) {
        guard emailTF.text != "" || emailTF.text != nil || emailTF.text != " " || passwordTF.text != "" || passwordTF.text != nil || passwordTF.text != " " else{
            let alertController = UIAlertController(title: "login failed!", message: "Email and Password required", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
                
            }
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return
        }
            
        
        
        SVProgressHUD.show()
        AuthUserService.manager.signIn(withEmail: emailTF.text!, password: passwordTF.text!)
    }
    
    @IBAction func createAccountPressed(_ sender: UIButton) {
        AuthUserService.manager.createUser(withEmail: emailTF.text!, password: passwordTF.text!)
    }
    
    
    
    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
   emailTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
    
    }
    
    
}

extension LoginViewController: AuthUserServiceDelegate{
    func didSignIn(_ userService: AuthUserService, user: AppUser) {
        SVProgressHUD.dismiss()
        present(MainTab.storyboardInstance(), animated: true) {
        }
    }
    
    func didFailSigningIn(_ userService: AuthUserService, error: Error) {
        let alertController = UIAlertController(title: "login failed!", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
            
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func didCreateUser(_ userService: AuthUserService, user: AppUser) {
        let alertController = UIAlertController(title: "Create User Successful!", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
            
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func didFailCreatingUser(_ userService: AuthUserService, error: Error) {
        let alertController = UIAlertController(title: "Create User Failed!", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
            
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
}

extension LoginViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        return true
    }
}

