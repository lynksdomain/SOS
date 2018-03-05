//
//  SiteDetailView.swift
//  SOS
//
//  Created by Masai Young on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class SiteDetailCollectionViewCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func commonInit() {
        prepareTitleLabel()
        prepareInfoLabel()
    }
    
    
    private func prepareTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(snp.width).multipliedBy(0.95)
            make.top.equalTo(snp.top).offset(10)
            make.centerX.equalTo(snp.centerX)
        }
    }
    
    private func prepareInfoLabel() {
        addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.width.equalTo(snp.width).multipliedBy(0.9)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.bottom.equalTo(snp.bottom).offset(-10)
            make.centerX.equalTo(snp.centerX)
        }
    }
}

class SiteDetailView: UIView {
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(SiteDetailCollectionViewCell.self, forCellReuseIdentifier: "DetailCell")
        tv.estimatedRowHeight = 100
        tv.rowHeight = UITableViewAutomaticDimension
        tv.allowsSelection = true
        return tv
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareTableView()
    }
    
    private func prepareTableView() {
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(snp.bottom)
        }
        
    }
    
}
