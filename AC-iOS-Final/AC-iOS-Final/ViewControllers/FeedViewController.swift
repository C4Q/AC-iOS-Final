//
//  FeedViewController.swift
//  
//
//  Created by C4Q on 2/26/18.
//

import UIKit
import FirebaseAuth

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logOutPressed(_ sender: AnyObject) {
        do {
            try Auth.auth().signOut()
             performSegue(withIdentifier: "goToLogin" , sender: nil)
        }
        catch {
            print("error: there was a problem logging out")
        }
    }
    

}
