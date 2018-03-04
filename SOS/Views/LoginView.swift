//
//  LoginView.swift
//  SOS
//
//  Created by Masai Young on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class LoginView: UIView {
    lazy var callToActionLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter PIN"
        label.textAlignment = .center
        return label
    }()
    
    lazy var passwordView: UITextField = {
        let tv = UITextField()
        tv.placeholder = "@ @ @ @"
        tv.font = UIFont(name: Stylesheet.Fonts.Bold, size: 30)
        tv.textAlignment = .center
        tv.isEnabled = false
        return tv
    }()
    
    lazy var feedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let cellSpacing: CGFloat = 10.0
        let numberOfCells: CGFloat = 3
        let numberOfSpaces: CGFloat = numberOfCells + 1
        layout.itemSize = CGSize(width: (screenWidth - (cellSpacing * numberOfSpaces)) / numberOfCells, height: screenHeight * 0.4)
        layout.sectionInset = UIEdgeInsetsMake(cellSpacing, cellSpacing , cellSpacing, cellSpacing )
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        collectionView.backgroundColor = Stylesheet.Colors.MainYellow
        collectionView.register(LoginCollectionViewCell.self, forCellWithReuseIdentifier: "feedCell")
        return collectionView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareCallToActionLabel()
        preparePasswordView()
        prepareCollectionView()
    }
    
    private func prepareCallToActionLabel() {
        self.addSubview(callToActionLabel)
        callToActionLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(50)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(snp.width).multipliedBy(0.8)
            make.height.equalTo(snp.height).dividedBy(8)
        }
    }
    
    private func preparePasswordView() {
        self.addSubview(passwordView)
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(80)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(snp.width).multipliedBy(0.8)
            make.height.equalTo(snp.height).dividedBy(8)
        }
    }
    private func prepareCollectionView() {
        self.addSubview(feedCollectionView)
        feedCollectionView.snp.makeConstraints { make in
            make.top.equalTo(snp.centerY).offset(-100)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(snp.bottom)
        }
    }
    
}
