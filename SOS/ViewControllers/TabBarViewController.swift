//
//  TabBarViewController.swift
//  SOS
//
//  Created by Masai Young on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class TabBarVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTabBar(into: self)
    }
    
    func applyTabBar(into controller: UIViewController) {
        let tabIcons: [String] = ["pinIcon", "userIcon", "forumIcon"]
        
        let tabController = AZTabBarController.insert(into: controller, withTabIconNames: tabIcons, andSelectedIconNames: tabIcons)
        
        // Set controllers inside tab bar
        tabController.setViewController(SearchViewController().inNavController(), atIndex: 0)
        tabController.setTitle("Search", atIndex: 0)
        
        tabController.setViewController(MyInfoViewController().inNavController(), atIndex: 1)
        tabController.setTitle("MyInfo", atIndex: 1)
        
        tabController.setViewController(ForumViewController().inNavController(), atIndex: 2)
        tabController.setTitle("FAQ", atIndex: 2)
        
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
