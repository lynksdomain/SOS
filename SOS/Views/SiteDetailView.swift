//
//  SiteDetailView.swift
//  SOS
//
//  Created by Masai Young on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class SiteDetailView: UIView {
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "DetailCell")
        tv.separatorStyle = .none
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
