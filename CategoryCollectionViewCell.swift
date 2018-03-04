//
//  CategoryCollectionViewCell.swift
//  SOS
//
//  Created by Masai Young on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.backgroundColor = Stylesheet.Colors.LightPink
        label.layer.borderColor = Stylesheet.Colors.LightGray.cgColor
        label.layer.borderWidth = 2.0
        label.layer.cornerRadius = 5.0
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    let categoryImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = Stylesheet.Colors.UltraLightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 2.0
        imageView.layer.cornerRadius = imageView.bounds.width/2.0
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func toggleColor() {
        switch categoryLabel.backgroundColor! {
        case Stylesheet.Colors.LightPink:
            categoryLabel.backgroundColor = Stylesheet.Colors.MainOrange
        case Stylesheet.Colors.MainOrange:
            categoryLabel.backgroundColor = Stylesheet.Colors.LightPink
        default:
            categoryLabel.backgroundColor = Stylesheet.Colors.LightPink
        }
    }
    
    private func setupViews(){
        setupCollectionLabel()
    }
    
    private func addSubViews() {
        addSubview(categoryLabel)
    }
    
    private func setupCollectionLabel(){
        categoryLabel.snp.makeConstraints { (constraint) in
            constraint.centerX.equalTo(self)
            constraint.centerY.equalTo(self)
            constraint.width.equalTo(snp.width)
            constraint.height.equalTo(snp.height).multipliedBy(0.5)
        }
    }
    
    // configure cell from viewController
    
}
