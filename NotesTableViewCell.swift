//
//  NotesTableViewCell.swift
//  SOS
//
//  Created by Ashlee Krammer on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class NotesTableViewCell: UITableViewCell {
    
    lazy var notesTextView: UITextView = {
        let ntv = UITextView()
        ntv.font = UIFont(name: Stylesheet.Fonts.Regular, size: 15)
        return ntv
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setUpView() {
        setUpTextView()
    }
    
    func setUpTextView(){
        addSubview(notesTextView)
        notesTextView.snp.makeConstraints { (make) in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    
}
