//
//  UIAlertController+Factory.swift
//  AC-iOS-Final
//
//  Created by Masai Young on 2/28/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

struct Alert {
    enum AlertType {
        case disabledFacebookButton
        case noImageToPost
        case postFailure
        case postSuccess
    }
    
    let title: String
    let message: String?
    let actions: [String]
    
    init(error: NSError) {
        title = error.localizedFailureReason ?? "Error"
        message = error.localizedDescription
        actions = ["OK"]
    }
    
    init(type: AlertType) {
        switch type {
        case .disabledFacebookButton:
            title = "Error"
            message = "Facebook button disabled for now"
            actions = ["OK"]
        case .noImageToPost:
            title = "Upload Failed!"
            message = "Provide an image to upload"
            actions = ["OK"]
        case .postFailure:
            title = "Upload Failed!"
            message = "DEV: Check console for error message"
            actions = ["OK"]
        case .postSuccess:
            title = "Photo Uploaded!"
            message = nil
            actions = ["OK"]
        }
    }
    
    static func present(from error: NSError) {
        let alert = Alert(error: error)
        let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
        let dismissAlert = UIAlertAction(title: alert.actions.first!, style: .default, handler: nil)
        let actions = [dismissAlert]
        actions.forEach({alertController.addAction($0)})
        if let topView = UIApplication.getTopViewController() {
            topView.present(alertController, animated: true, completion: nil)
        }
    }
    
    static func present(from type: AlertType) {
        let alert = Alert(type: type)
        let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
        var actions = [UIAlertAction]()
        for actionTitle in alert.actions {
            let newAlert = UIAlertAction(title: actionTitle, style: .default, handler: nil)
            actions.append(newAlert)
        }
        actions.forEach({alertController.addAction($0)})
        if let topView = UIApplication.getTopViewController() {
            topView.present(alertController, animated: true, completion: nil)
        }
    }
}

