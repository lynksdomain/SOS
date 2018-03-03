//
//  MyInfoViewController.swift
//  SOS
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class MyInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< Updated upstream
=======
        view.addSubview(myInfoView)
        myInfoView.tableView.delegate = self
        myInfoView.tableView.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
        myInfoView.tableView.register(NotesTableViewCell.self, forCellReuseIdentifier: "NotesCell")
        myInfoView.tableView.register(ProfileCells.self, forCellReuseIdentifier: "ProfileCell")
        myInfoView.tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: "HistoryCell")
        myInfoView.tableView.allowsSelection = false
    }
    
    @objc private func editButton() {
        counter += 1
        editPage(counter: counter)
        myInfoView.tableView.reloadData()
    }
    
    @objc private func logOut() {
        dismiss(animated: true, completion: nil)
    }
    
    
}
>>>>>>> Stashed changes

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
