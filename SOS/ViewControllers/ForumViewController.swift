//
//  ForumViewController.swift
//  SOS
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class ForumViewController: UIViewController {
    var forumView = ForumView()
    
    var forumQuestions: [String] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(forumView)
        view.backgroundColor = Stylesheet.Colors.White
//        forumView.tableView.dataSource = self
        forumView.tableView.rowHeight = UITableViewAutomaticDimension
        forumView.tableView.estimatedRowHeight = 120
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



extension ForumViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

