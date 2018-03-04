//
//  UIApplication+topViewController.swift
//  AC-iOS-Final
//
//  Created by Masai Young on 2/28/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

extension UIApplication {
    static func getTopViewController() -> UIViewController? {
        var topController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        while topController?.presentedViewController != nil {
            topController = topController?.presentedViewController
        }
        return topController
    }

}
