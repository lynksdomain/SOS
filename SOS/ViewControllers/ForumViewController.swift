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
    
    var forumQuestions: [ForumQuestion] = [] {
        didSet {
            forumView.tableView.reloadData()
            print("forumQuestions: \(forumQuestions.count)")
        }
    }
    
    var categories: [String] = []

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let questions = JSONParsingService.parseJSONFile(filename: "ForumQA", type: "json") {
            forumQuestions = questions
        }
        
        view.addSubview(forumView)
        view.backgroundColor = Stylesheet.Colors.White
        forumView.tableView.dataSource = self
        forumView.tableView.rowHeight = UITableViewAutomaticDimension
        forumView.tableView.estimatedRowHeight = 120
        
        configureNavBar()
    }

    private func configureNavBar() {
        navigationItem.title = "F.A.Q."
        
        let askBarItem = UIBarButtonItem(title: "Ask", style: .plain, target: self, action: #selector(askAQuestion))
        navigationItem.rightBarButtonItem = askBarItem
    }
    
    @objc func askAQuestion() {
        let addQuestionVC = AddQuestionViewController()
        present(addQuestionVC, animated: true, completion: nil)
    }
}


extension ForumViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forumQuestions.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForumQuestionCell", for: indexPath) as! ForumQuestionTableViewCell
        let currentQuestion = forumQuestions[indexPath.row]
        cell.questionLabel.text = currentQuestion.question
        cell.answerLabel.text = currentQuestion.answer
        
        return cell
    }
    
    
}


extension ForumViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Safe Sex"
        case 1:
            return "Birth Control"
        case 2:
            return "STD Testing"
        default:
            return "Other"
        }
    }
    
    
    
    
    
}
