//
//  ProfileCells.swift
//  SOS
//
//  Created by Ashlee Krammer on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class ProfileCells: UITableViewCell {

    lazy var titleLabel: UILabel = {
        let tl = UILabel()
        return tl
    }()
    
    lazy var answertf: UITextField = {
        let tf = UITextField()
        return tf
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setUpView() {
        setUpLabel()
        setUpTF()
    }
    
    func setUpLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.top.bottom.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)

        }
    }
    
    func setUpTF() {
        addSubview(answertf)
        answertf.snp.makeConstraints { (make) in
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.top.bottom.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)

        }
    }
    
}
