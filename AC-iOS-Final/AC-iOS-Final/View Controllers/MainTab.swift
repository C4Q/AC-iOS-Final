//
//  MainTab.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class MainTab: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
  static public func storyboardInstance() -> UITabBarController{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tab = UITabBarController()
        let feed = storyboard.instantiateViewController(withIdentifier: "FeedTableViewController")
        let uploadVC = storyboard.instantiateViewController(withIdentifier: "UploadViewController")
        let feedNav = UINavigationController(rootViewController: feed)
        let  uploadNav = UINavigationController(rootViewController: uploadVC)
        feedNav.tabBarItem = UITabBarItem(title: "Feed", image: #imageLiteral(resourceName: "chickenleg") , tag: 0)
        uploadNav.tabBarItem = UITabBarItem(title: "Upload", image: #imageLiteral(resourceName: "upload"), tag: 1)
        tab.viewControllers = [feedNav, uploadNav]
        return tab
    }

}
