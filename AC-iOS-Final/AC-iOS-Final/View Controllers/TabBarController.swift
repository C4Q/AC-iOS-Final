//
//  TabBarController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: StoryBoard instance
    public static func storyboardInstance() -> TabBarController {
        let storyboard = UIStoryboard(name: "TabBar", bundle: nil) //name of the storyboard file
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController //name of VC file
        return tabBarController
    }
}
