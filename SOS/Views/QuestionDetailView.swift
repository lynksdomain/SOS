//
//  QuestionDetailView.swift
//  SOS
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class QuestionDetailView: UIView {

    lazy var questionLabel: UILabel = {
        let lb = UILabel()
        lb.text = " "
        lb.font = UIFont(name: Stylesheet.Fonts.Regular, size: 18.0)
        lb.numberOfLines = 0
        return lb
    }()
    
    //usernameLabel - for user name
    lazy var answerTextview: UITextView = {
        let tv = UITextView()
        tv.text = " "
        tv.dataDetectorTypes = UIDataDetectorTypes.link
        tv.font = UIFont(name: Stylesheet.Fonts.Thin, size: 18.0)
        tv.isEditable = false
      
        return tv
    }()

    
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
        self.addSubview(questionLabel)
        self.addSubview(answerTextview)
        setupConstraints()
    }
    
    private func setupConstraints() {
        questionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
            //            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
        
        
        answerTextview.snp.makeConstraints { (make) in
            make.top.equalTo(questionLabel.snp.bottom).offset(20)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }
}
