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
    let contentView = LoginView()
    let model = ["1","2","3","4","5","6","7","8","9","0", "Clear", "X"]
    let correctPassword = "9999"
    var password = "" {
        didSet {
            if password.count >= 4 {
                validatePassword()
            }
        }
    }
    
    let pinLength = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        prepareContentView()
        contentView.feedCollectionView.delegate = self
        contentView.feedCollectionView.dataSource = self
        contentView.passwordView.delegate = self
    }
    
    private func prepareContentView() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(view.snp.edges)
        }
    }
    
    func validatePassword() {
        if password == correctPassword {
            present(TabBarVC(), animated: true, completion: nil)
            contentView.passwordView.text?.removeAll()
            password = ""
        } else {
            Alert.present(from: .wrongPassword)
        }
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
        
        if contentView.passwordView.text != nil {
            if let numericalText = Int(labelText) {
                contentView.passwordView.text! += numericalText.description
                self.password = contentView.passwordView.text!
            }
            
            if labelText == "X" {
                if !(contentView.passwordView.text?.isEmpty)! {
                    contentView.passwordView.text?.removeLast()
                    self.password = contentView.passwordView.text!
                }
            }
            
            if labelText == "Clear" {
                contentView.passwordView.text?.removeAll()
                self.password = contentView.passwordView.text!
            }
        }
        
        
    }
}

extension LoginViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedCell", for: indexPath) as! LoginCollectionViewCell
        cell.backgroundColor = .blue
        cell.numberLabel.text = model[indexPath.row].description
        return cell
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        if text.count >= pinLength {
            return false
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        print("hi")
    }

}
