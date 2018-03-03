//
//  MyInfoViewController.swift
//  SOS
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class MyInfoViewController: UIViewController {

    let myInfoView = MyInfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myInfoView)
        myInfoView.tableView.delegate = self
        myInfoView.tableView.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButton))
//        myInfoView.tableView.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellReuseIdentifier: <#T##String#>)
    }

    @objc private func editButton() {
        
    }
    

}

extension MyInfoViewController: UITableViewDelegate {
    
}

extension MyInfoViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: <#T##String#>, for: indexPath)
        return UITableViewCell()
    }
    
}
