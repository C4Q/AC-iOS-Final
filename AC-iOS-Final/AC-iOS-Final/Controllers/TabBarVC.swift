//
//  TabBarVC.swift
//  AC-iOS-Final
//
//  Created by Masai Young on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import FirebaseAuth.FIRUser

class TabBarVC: UIViewController {
    
    lazy var loginCoordinator: LoginCoordinator = {
        return LoginCoordinator(rootViewController: self)
    }()
    
    func showLogin() {
        loginCoordinator.start()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTabBar(into: self)
        if AuthClient.currentUser == nil {
            showLogin()
        }
    }
    
    func applyTabBar(into controller: UIViewController) {
        let tabIcons: [String] = ["chickenleg", "upload"]
        
        let tabController = AZTabBarController.insert(into: controller, withTabIconNames: tabIcons, andSelectedIconNames: tabIcons)
        
        // Set controllers inside tab bar
        tabController.setViewController(FeedVC().inNavController(), atIndex: 0)
        tabController.setTitle("Feed", atIndex: 0)
        
        
        tabController.setViewController(UploadVC().inNavController(), atIndex: 1)
        tabController.setTitle("Upload", atIndex: 1)
        
        // Configure tab bar apparance
        tabController.defaultColor = Stylesheet.Contexts.TabBarController.DefaultColor
        tabController.selectedColor = Stylesheet.Contexts.TabBarController.SelectedColor
        tabController.highlightColor = Stylesheet.Contexts.TabBarController.HighlightColor
        tabController.highlightedBackgroundColor = Stylesheet.Contexts.TabBarController.HighlightedBackgroundColor
        tabController.buttonsBackgroundColor = Stylesheet.Contexts.TabBarController.ButtonsBackgroundColor
        tabController.selectionIndicatorColor = Stylesheet.Contexts.TabBarController.SelectionIndicatorColor
        tabController.selectionIndicatorHeight = 3.0
        tabController.separatorLineColor = Stylesheet.Contexts.TabBarController.SeparatorLineColor
        tabController.separatorLineVisible = true
        tabController.animateTabChange = true
    }
}

extension TabBarVC: AuthDelegate {
    func didSignIn(user: User) {
        print("Signed in user \(String(describing: user.email?.description))")
        loginCoordinator.finish()
    }
    
    func didCreateUser(user: User) {
        print("Created user \(String(describing: user.email?.description))")
        loginCoordinator.finish()
    }
    
    func failedSignIn(error: Error) {
        print("Failed to sign in!")
        handle(error: error)
    }
    
    func failedCreateUser(error: Error) {
        print("Failed to create user!")
        handle(error: error)
    }
    
}


