//
//  LoginTableViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class LoginTableViewController: UITableViewController {
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    @IBAction func loginRegisterButton(_ sender: UIButton) {
        guard userEmailTextField.text != "" , userPasswordTextField.text != "" , userEmailTextField.text != " " , userPasswordTextField.text != " " else {
            emailPasswordAlertMessage()
            return
        }
        guard let email = userEmailTextField.text, let password = userPasswordTextField.text else {
            emailPasswordAlertMessage()
            return
        }
        AuthenticationService.manager.signIn(email: email, password: password, completion: { (user) in
            let alertController = UIAlertController(title: "Login Successful", message: nil, preferredStyle: .alert)
            let okAlertAction = UIAlertAction(title: "Ok", style: .default, handler: {(action) in
                self.performSegue(withIdentifier: "feedSegue", sender: self)
            })
            alertController.addAction(okAlertAction)
            self.present(alertController, animated: true, completion: nil)
        }) { (error) in
            let alertController = UIAlertController(title: "there is no account with this credintials", message: "would you like to create an account ?", preferredStyle: .alert)
            let okAlertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action) in
                AuthenticationService.manager.createUser(email: email, password: password, completion: { (user) in
                    self.performSegue(withIdentifier: "feedSegue", sender: self)
                }, errorHandler: { (error) in
                    print(error)
                })
            })
            alertController.addAction(okAlertAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    func emailPasswordAlertMessage(){
        let alertController = UIAlertController(title: "Please add a valid Email and Password", message: nil, preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAlertAction)
        present(alertController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        userEmailTextField.delegate = self
        userPasswordTextField.delegate = self
       tableView.allowsSelection = false
        tableView.separatorColor = .clear
    }
    override func viewWillAppear(_ animated: Bool) {
        if AuthenticationService.manager.getCurrentUser() != nil{
            self.performSegue(withIdentifier: "feedSegue", sender: self)
        }
    }
    
   

}
extension LoginTableViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
