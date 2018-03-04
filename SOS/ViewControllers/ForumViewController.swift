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
    
    var categoriesDict: [String:[ForumQuestion]] = [:]
    
    var categories: [String] = [] {
        didSet {
            print("categories: \(categories)")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let questions = JSONParsingService.parseJSONFile(filename: "ForumQA", type: "json") {
            forumQuestions = questions
        }
        
        for ques in forumQuestions {
            if !categoriesDict.keys.contains(ques.category) {
                categoriesDict[ques.category] = [ForumQuestion]()
                categoriesDict[ques.category]?.append(ques)
                categories.append(ques.category)
            } else {
                categoriesDict[ques.category]?.append(ques)
            }
        }
        navigationController?.navigationBar.tintColor = Stylesheet.Colors.MainOrange
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(forumView)
        view.backgroundColor = Stylesheet.Colors.White
        forumView.tableView.dataSource = self
        forumView.tableView.delegate = self
        forumView.tableView.rowHeight = UITableViewAutomaticDimension
        forumView.tableView.estimatedRowHeight = 120
        configureNavBar()
    }

    private func configureNavBar() {
        navigationItem.title = "F.A.Q."
        let textAttributes = [NSAttributedStringKey.foregroundColor: Stylesheet.Colors.MainOrange]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }

}


extension ForumViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = Stylesheet.Colors.MainYellow
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.black
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categoriesDict.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // load number of question cells per category
        
        switch section {
        case 0:
            return categoriesDict[categories[0]]!.count
        case 1:
            return categoriesDict[categories[1]]!.count
        case 2:
            return categoriesDict[categories[2]]!.count
        case 3:
            return categoriesDict[categories[3]]!.count
        case 4:
            return categoriesDict[categories[4]]!.count
        default:
            return 0
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ForumQuestionCell", for: indexPath) as! ForumQuestionTableViewCell
            let currentQuestion = categoriesDict[categories[0]]![indexPath.row]
            cell.questionLabel.text = currentQuestion.question
            cell.answerLabel.text = currentQuestion.answer
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ForumQuestionCell", for: indexPath) as! ForumQuestionTableViewCell
            let currentQuestion = categoriesDict[categories[1]]![indexPath.row]
            cell.questionLabel.text = currentQuestion.question
            cell.answerLabel.text = currentQuestion.answer
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ForumQuestionCell", for: indexPath) as! ForumQuestionTableViewCell
            let currentQuestion = categoriesDict[categories[2]]![indexPath.row]
            cell.questionLabel.text = currentQuestion.question
            cell.answerLabel.text = currentQuestion.answer
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ForumQuestionCell", for: indexPath) as! ForumQuestionTableViewCell
            let currentQuestion = categoriesDict[categories[3]]![indexPath.row]
            cell.questionLabel.text = currentQuestion.question
            cell.answerLabel.text = currentQuestion.answer
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ForumQuestionCell", for: indexPath) as! ForumQuestionTableViewCell
            let currentQuestion = categoriesDict[categories[4]]![indexPath.row]
            cell.questionLabel.text = currentQuestion.question
            cell.answerLabel.text = currentQuestion.answer
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ForumQuestionCell", for: indexPath) as! ForumQuestionTableViewCell
            let currentQuestion = categoriesDict[categories[0]]![indexPath.row]
            cell.questionLabel.text = currentQuestion.question
            cell.answerLabel.text = currentQuestion.answer
            return cell
        }
    }
}



extension ForumViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return categories[0]
        case 1:
            return categories[1]
        case 2:
            return categories[2]
        case 3:
            return categories[3]
        case 4:
            return categories[4]
        default:
            return "Other"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            let questionSetup = categoriesDict[categories[0]]![indexPath.row]
            let dvc = QuestionDetailViewController(question: questionSetup)
            self.navigationController?.pushViewController(dvc, animated: true)
        case 1:
            let questionSetup = categoriesDict[categories[1]]![indexPath.row]
            let dvc = QuestionDetailViewController(question: questionSetup)
            self.navigationController?.pushViewController(dvc, animated: true)
        case 2:
            let questionSetup = categoriesDict[categories[2]]![indexPath.row]
            let dvc = QuestionDetailViewController(question: questionSetup)
            self.navigationController?.pushViewController(dvc, animated: true)
        case 3:
            let questionSetup = categoriesDict[categories[3]]![indexPath.row]
            let dvc = QuestionDetailViewController(question: questionSetup)
            self.navigationController?.pushViewController(dvc, animated: true)
        case 4:
            let questionSetup = categoriesDict[categories[4]]![indexPath.row]
            let dvc = QuestionDetailViewController(question: questionSetup)
            self.navigationController?.pushViewController(dvc, animated: true)
        default:
            let questionSetup = categoriesDict[categories[0]]![indexPath.row]
            let dvc = QuestionDetailViewController(question: questionSetup)
            self.navigationController?.pushViewController(dvc, animated: true)
        }
    }
}


