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
    var counter = 0
    override func viewDidLoad() {
        super.viewDidLoad()
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

extension MyInfoViewController: UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Profile"
        case 1:
            return "History"
        case 2:
            return "Notes"
        default:
            return "Other"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 2:
            return 200
        default:
            return 50
        }
    }
    
}

extension MyInfoViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 4
        case 2:
            return 1
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let profileCell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCells
            
            editTextFields(textField: profileCell.answertf)
            editCellColorDuringEditing(cell: profileCell)
            
            switch indexPath.row  {
            case 0 :
                profileCell.titleLabel.text = "  Sex"
            case 1:
                profileCell.titleLabel.text = "  Age"
            case 2:
                profileCell.titleLabel.text = "  Zip Code"
            default:
                break
            }
            return profileCell
            
        case 1:
            let historyCell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryTableViewCell
            
            editTextFields(textField: historyCell.answertf)
            editCellColorDuringEditing(cell: historyCell)
            
            switch indexPath.row  {
            case 0 :
                historyCell.titleLabel.text = "  Last Period"
            case 1:
                historyCell.titleLabel.text = "  Last Sexual Activity"
            case 2:
                historyCell.titleLabel.text = "  Last STD Test"
            case 3:
                historyCell.titleLabel.text = "  Last HIV Test"
            default:
                break
            }
            return historyCell
            
        case 2:
            let notesCell = tableView.dequeueReusableCell(withIdentifier: "NotesCell", for: indexPath) as! NotesTableViewCell
            editNotes(notes: notesCell.notesTextView)
            editCellColorDuringEditing(cell: notesCell)
            return notesCell
        default:
            let cell = UITableViewCell()
            return cell
        }
        
    }
    
}

extension MyInfoViewController {
    
    func editPage(counter: Int) {
        switch counter % 2 {
        case 1:
            navigationItem.rightBarButtonItem?.title = "Done"
        case 0:
            navigationItem.rightBarButtonItem?.title = "Edit"
        default:
            break
        }
    }
    
    func editTextFields(textField: UITextField) {
        switch counter % 2 {
        case 1:
            textField.isEnabled = true
            textField.backgroundColor = .lightText
            textField.layer.borderWidth = 1.0
            textField.layer.borderColor = UIColor.black.cgColor
            textField.borderStyle = .roundedRect
        case 0:
            textField.isEnabled = false
            textField.backgroundColor = Stylesheet.Colors.LightPink
            textField.layer.borderWidth = 0.0
            textField.borderStyle = .none
        default:
            break
        }
    }
    
    func editNotes(notes: UITextView){
        switch counter % 2 {
        case 1:
            notes.isEditable = true
            notes.backgroundColor = .lightText
        case 0:
            notes.isEditable = false
            notes.backgroundColor = Stylesheet.Colors.LightPink
        default:
            break
        }
    }
    
    func editCellColorDuringEditing(cell: UITableViewCell) {
        cell.backgroundColor = Stylesheet.Colors.LightPink
    }
}

