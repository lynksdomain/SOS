//
//  ForumView.swift
//  SOS
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class ForumView: UIView {

   // add table view
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        //create and register a cell
        tv.register(ForumQuestionTableViewCell.self, forCellReuseIdentifier: "ForumQuestionCell")
        tv.backgroundColor = .clear
        tv.isHidden = false
        return tv
    }()
    
    // connect to table view cell

    
    // setup custom view
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        self.addSubview(tableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top)
            make.width.equalTo(snp.width)
            make.bottom.equalTo(snp.bottom)
        }
    }
}
