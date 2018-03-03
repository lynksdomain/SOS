//
//  ForumQuestionTableViewCell.swift
//  SOS
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class ForumQuestionTableViewCell: UITableViewCell {
    
    lazy var questionLabel: UILabel = {
        let lb = UILabel()
        lb.text = ""
        
        return lb
    }()
    
    //usernameLabel - for user name
    lazy var answerLabel: UILabel = {
        let lb = UILabel()
        lb.text = ""
      
        return lb
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "ForumQuestionCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        self.addSubview(questionLabel)
        self.addSubview(answerLabel)
        setupConstraints()
    }
    
    
    private func setupConstraints() {
        questionLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(5)
            make.leading.equalTo(self.snp.leading).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
//            make.height.equalTo(.snp.height).multipliedBy(0.5)
        }
     
        answerLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(questionLabel.snp.bottom).offset(5)
            make.leading.equalTo(self.snp.leading).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
            //            make.height.equalTo(.snp.height).multipliedBy(0.5)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
