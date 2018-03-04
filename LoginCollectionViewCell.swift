//
//  LoginCollectionViewCell.swift
//  SOS
//
//  Created by Masai Young on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class LoginCollectionViewCell: UICollectionViewCell {
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
