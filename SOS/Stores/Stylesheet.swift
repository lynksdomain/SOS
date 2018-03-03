//
//  Supporting Files.swift
//  FlashcardHW
//
//  Created by Masai Young on 2/12/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit

enum Stylesheet {
    
    enum Colors {
        static let White = UIColor(hex: "#FBFCFF")
        static let Black = UIColor(hex: "#262626")
        static let DarkGray = UIColor(hex: "#333333")
        static let LightGray = UIColor(hex: "#919191")
        static let Blue = UIColor(hex: "#7AA0CC")
        static let LightBlue = UIColor(hex: "#9AC9FF")
        static let UltraLightGray = UIColor(hex: "e8e8e8")
        // Colors borrowed from Tweetbot's dark color scheme
    }
    
    enum Fonts {
        static let Bold = "HelveticaNeue-Bold"
        static let Thin = "HelveticaNeue-Thin"
        static let Light = "HelveticaNeue-Light"
    }
    
    enum Contexts {
        enum Global {
            //            static let StatusBarStyle = UIStatusBarStyle.LightContent
            static let BackgroundColor = Colors.White
            
        }
        
        enum NavigationController {
            static let BarTintColor = Colors.Black
            static let BarTextColor = Colors.White
            static let BarColor = Colors.LightGray
        }
        
        enum TabBarController {
            //default color of the icons on the buttons
            static let DefaultColor = Stylesheet.Colors.LightGray
            
            //the color of the icon when a menu is selected
            static let SelectedColor =  Stylesheet.Colors.DarkGray
            
            //The color of the icon of a highlighted tab
            static let HighlightColor = UIColor.white
            
            //The background color of the button of the highlighted tabs.
            static let HighlightedBackgroundColor = UIColor.green
            
            //The background color of the tab bar
            static let ButtonsBackgroundColor = Stylesheet.Colors.White
            //            static let ButtonsBackgroundColor = Stylesheet.Colors.Blue
            
            //The color of the selection indicator.
            static let SelectionIndicatorColor = Stylesheet.Colors.LightBlue
            
            // change the seperator line color
            static let SeparatorLineColor = Stylesheet.Colors.LightGray
        }
        
    }
    
}

