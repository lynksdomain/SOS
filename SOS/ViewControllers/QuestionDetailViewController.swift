//
//  QuestionDetailViewController.swift
//  SOS
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class QuestionDetailViewController: UIViewController {
    let questionView = QuestionDetailView()
    var question: ForumQuestion!
    init(question: ForumQuestion) {
        super.init(nibName: nil, bundle: nil)
        self.question = question
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupQuestionDetailView()
        configureViews()
        configureNavBar()
    }
    private func configureViews() {
        self.questionView.questionLabel.text = self.question?.question
        self.questionView.answerTextview.text = self.question?.answer
    }
    
    private func configureNavBar() {
        
        navigationItem.title = self.question?.category
        
    }
    
    private func setupQuestionDetailView(){
        view.addSubview(questionView)
        questionView.snp.makeConstraints { (constraint) in
            constraint.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}
