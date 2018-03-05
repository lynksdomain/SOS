//
//  MyInfoView.swift
//  SOS
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import  SnapKit

class MyInfoView: UIView {

//    lazy var editButton: UIBarButtonItem = {
//        let eb = UIBarButtonItem()
//        return eb
//    }()
//    
    lazy var tableView: UITableView = {
       let tv = UITableView()
        tv.separatorStyle = .none
        return tv
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        setUpTableView()
    }

    
    func setUpTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    

}
