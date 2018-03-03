//
//  LoginViewController.swift
//  SOS
//
//  Created by C4Q on 3/3/18.
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
        tv.textAlignment = .center
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
        collectionView.backgroundColor = Stylesheet.Colors.LightPink
        collectionView.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: "feedCell")
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

class FeedCollectionViewCell: UICollectionViewCell {
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = Stylesheet.Colors.LightPink
        label.textAlignment = .center
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareNumberLabel()
    }
    
    private func prepareNumberLabel() {
        self.addSubview(numberLabel)
        numberLabel.snp.makeConstraints { make in
            make.edges.equalTo(snp.edges)
        }
    }
}

class LoginViewController: UIViewController {
    
    let contentView = LoginView()
    let model = [1,2,3,4,5,6,7,8,9,0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        prepareContentView()
        contentView.feedCollectionView.delegate = self
        contentView.feedCollectionView.dataSource = self
    }
    
    private func prepareContentView() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(view.snp.edges)
        }
    }
    
}

extension LoginViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.width / 4)
    }
}

extension LoginViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedCell", for: indexPath) as! FeedCollectionViewCell
        cell.backgroundColor = .blue
        cell.numberLabel.text = model[indexPath.row].description
        return cell
    }
    
    
}
