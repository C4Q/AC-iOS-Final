//
//  TabBarVC.swift
//  AC-iOS-Final
//
//  Created by Masai Young on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class TabBarVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTabBar(into: self)
    }
    
    func applyTabBar(into controller: UIViewController) {
        let tabIcons: [String] = ["chickenleg", "upload"]
        
        let tabController = AZTabBarController.insert(into: controller, withTabIconNames: tabIcons, andSelectedIconNames: tabIcons)
        
        // Set controllers inside tab bar
        tabController.setViewController(ViewController(), atIndex: 0)
        tabController.setTitle("Feed", atIndex: 0)
        
        
        tabController.setViewController(ViewController(), atIndex: 1)
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


