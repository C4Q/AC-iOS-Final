//
//  UIAlertController+Factory.swift
//  AC-iOS-Final
//
//  Created by Masai Young on 2/28/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

extension UIAlertController {
    static func create(from error: NSError) {
        let alertController = UIAlertController(title: error.localizedFailureReason ?? "Error", message: error.localizedDescription, preferredStyle: .alert)
        let me = UIAlertAction(title: "OK", style: .default, handler: nil)
        let actions = [me]
        actions.forEach({alertController.addAction($0)})
        if let topView = UIApplication.getTopViewController() {
            topView.present(alertController, animated: true, completion: nil)
        }
    }
    
    static func createFacebookButtonError() {
        let alertController = UIAlertController(title: "Error", message: "Facebook button disabled for now.", preferredStyle: .alert)
        let me = UIAlertAction(title: "OK", style: .default, handler: nil)
        let actions = [me]
        actions.forEach({alertController.addAction($0)})
        if let topView = UIApplication.getTopViewController() {
            topView.present(alertController, animated: true, completion: nil)
        }
    }
}
