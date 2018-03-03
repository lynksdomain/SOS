//
//  TabBarViewController.swift
//  SOS
//
//  Created by Masai Young on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class TabBarVC: UIViewController {
    
    var model = TestSiteDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTabBar(into: self)
    }
    
    func applyTabBar(into controller: UIViewController) {
        let tabIcons: [String] = ["pinIcon", "userIcon", "forumIcon"]
        
        let tabController = AZTabBarController.insert(into: controller, withTabIconNames: tabIcons, andSelectedIconNames: tabIcons)
        
        // Set controllers inside tab bar
        tabController.setViewController(SearchViewController().inNavController(), atIndex: 0)
        tabController.setTitle("Sites", atIndex: 0)
        
        tabController.setViewController(MyInfoViewController().inNavController(), atIndex: 1)
        tabController.setTitle("User", atIndex: 1)
        tabController.highlightButton(atIndex: 1)
        
        tabController.setViewController(ForumViewController().inNavController(), atIndex: 2)
        tabController.setTitle("Forum", atIndex: 2)
        
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

//extension TabBarVC: AuthDelegate {
//    func didSignIn(user: User) {
//        print("Signed in user \(String(describing: user.email?.description))")
//        loginCoordinator.finish()
//    }
//
//    func didCreateUser(user: User) {
//        print("Created user \(String(describing: user.email?.description))")
//        loginCoordinator.finish()
//    }
//
//    func failedSignIn(error: Error) {
//        print("Failed to sign in!")
//        handle(error: error)
//    }
//
//    func failedCreateUser(error: Error) {
//        print("Failed to create user!")
//        handle(error: error)
//    }
//
//}



