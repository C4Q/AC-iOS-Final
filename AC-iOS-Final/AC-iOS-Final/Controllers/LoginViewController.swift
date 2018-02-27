//
//  LoginViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        
        SVProgressHUD.show()

        Auth.auth().createUser(withEmail: EmailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print(error!)
            } else {
                //success
                print("registration successful!")
                if user != nil {
                    self.showOKAlert(title: "\((user?.email)!) Created!", message: "Good Job!", dismissCompletion: {
                        action in self.performSegue(withIdentifier: "toFeed", sender: self)
                    })
                }
                else {
                    self.showOKAlert(title: "Error", message: error?.localizedDescription)
                }
    
                SVProgressHUD.dismiss()
                //self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        }
        
    }
    
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {

        SVProgressHUD.show()

        Auth.auth().signIn(withEmail: EmailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print(error!)
                SVProgressHUD.dismiss()
                self.showOKAlert(title: "Error", message: error?.localizedDescription)
                
            } else {
                //success
                print("login successful")
                if user != nil {
                    self.showOKAlert(title: "\((user?.email)!) Logged In!", message: nil, dismissCompletion: {
                        action in self.performSegue(withIdentifier: "toFeed", sender: self)
                    })
                }
                else {
                    SVProgressHUD.dismiss()
                    self.showOKAlert(title: "Error", message: error?.localizedDescription)
                }
                SVProgressHUD.dismiss()
            }
        }
    }
    
    func showOKAlert(title: String, message: String?, dismissCompletion: ((UIAlertAction) -> Void)? = nil, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: dismissCompletion)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: completion)
    }
    

}
