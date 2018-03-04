//
//  LoginViewController.swift
//  SOS
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

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
        contentView.passwordView.delegate = self
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

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        if text.count >= 4 {
            return false
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        print("hi")
    }
    
}
