//
//  LoginViewController.swift
//  SOS
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import LocalAuthentication


class LoginViewController: UIViewController {

    enum PasswordPin: String {
        case one = "1"
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5"
        case six = "6"
        case seven = "7"
        case eight = "8"
        case nine = "9"
        case zero = "0"
        case clear = "Clear"
        case delete = "X"
    }
    
    let contentView = LoginView()
    let enumModel: [PasswordPin] = [.one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero, .clear, .delete]
    let correctPassword = "9999"
    var password = "" {
        didSet {
            if password.count >= 4 {
                validatePassword()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        prepareContentView()
        contentView.feedCollectionView.delegate = self
        contentView.feedCollectionView.dataSource = self
        contentView.touchIDImageView.addTarget(self, action: #selector(authenticationWithTouchID), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .orange
    }
    
    private func prepareContentView() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(view.snp.edges)
        }
    }
    
    private func validatePassword() {
        if password == correctPassword {
            present(TabBarVC(), animated: true, completion: nil)
            view.backgroundColor = .green
        } else {
            Alert.present(from: .wrongPassword)
        }
        clearPasswordField()
    }
    
    private func clearPasswordField() {
        contentView.passwordView.text?.removeAll()
        password = ""
    }
    
}

extension LoginViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.width / 4)
    }
}

extension LoginViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)! as! LoginCollectionViewCell
        guard let labelText = cell.numberLabel.text else { return }
        guard let pin = PasswordPin.init(rawValue: labelText) else { return }
        guard let passwordInput = contentView.passwordView.text else { return }
            switch pin {
            case .clear:
                clearPasswordField()
            case .delete:
                if !(contentView.passwordView.text?.isEmpty)! {
                    contentView.passwordView.text?.removeLast()
                    self.password = passwordInput
                }
            default:
                contentView.passwordView.text! += pin.rawValue
                self.password = contentView.passwordView.text!
            }
        
    }
}

extension LoginViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return enumModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedCell", for: indexPath) as! LoginCollectionViewCell
        cell.backgroundColor = .blue
        cell.numberLabel.text = enumModel[indexPath.row].rawValue
        return cell
    }
    
}



extension LoginViewController{
    
    @objc func authenticationWithTouchID() {
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = "Use Passcode"
        
        var authError: NSError?
        let reasonString = "To access the secure data"
        
        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString) { success, evaluateError in
                
                if success {
                    DispatchQueue.main.async {
                        self.present(TabBarVC(), animated: true, completion: nil)
                    }
                    //TODO: User authenticated successfully, take appropriate action
                    
                } else {
                    //TODO: User did not authenticate successfully, look at error and take appropriate action
                    guard let error = evaluateError else {
                        return
                    }
                    
                    print(self.evaluateAuthenticationPolicyMessageForLA(errorCode: error._code))
                    
                    //TODO: If you have choosen the 'Fallback authentication mechanism selected' (LAError.userFallback). Handle gracefully
                    
                }
            }
        } else {
            
            guard let error = authError else {
                return
            }
            //TODO: Show appropriate alert if biometry/TouchID/FaceID is lockout or not enrolled
            print(self.evaluateAuthenticationPolicyMessageForLA(errorCode: error.code))
        }
    }
    
    func evaluatePolicyFailErrorMessageForLA(errorCode: Int) -> String {
        var message = ""
        if #available(iOS 11.0, macOS 10.13, *) {
            switch errorCode {
            case LAError.biometryNotAvailable.rawValue:
                message = "Authentication could not start because the device does not support biometric authentication."
                
            case LAError.biometryLockout.rawValue:
                message = "Authentication could not continue because the user has been locked out of biometric authentication, due to failing authentication too many times."
                
            case LAError.biometryNotEnrolled.rawValue:
                message = "Authentication could not start because the user has not enrolled in biometric authentication."
                
            default:
                message = "Did not find error code on LAError object"
            }
        } else {
            switch errorCode {
            case LAError.touchIDLockout.rawValue:
                message = "Too many failed attempts."
                
            case LAError.touchIDNotAvailable.rawValue:
                message = "TouchID is not available on the device"
                
            case LAError.touchIDNotEnrolled.rawValue:
                message = "TouchID is not enrolled on the device"
                
            default:
                message = "Did not find error code on LAError object"
            }
        }
        
        return message;
    }
    
    func evaluateAuthenticationPolicyMessageForLA(errorCode: Int) -> String {
        
        var message = ""
        
        switch errorCode {
            
        case LAError.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"
            
        case LAError.appCancel.rawValue:
            message = "Authentication was cancelled by application"
            
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.notInteractive.rawValue:
            message = "Not interactive"
            
        case LAError.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
            
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        case LAError.userCancel.rawValue:
            message = "The user did cancel"
            
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"
            
        default:
            message = evaluatePolicyFailErrorMessageForLA(errorCode: errorCode)
        }
        
        return message
    }
}

