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
        view.backgroundColor = Stylesheet.Colors.White
        navigationController?.navigationBar.tintColor = Stylesheet.Colors.MainOrange
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
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = Stylesheet.Colors.MainYellow
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.black
    }
    
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
            profileCell.answertf.delegate = self
            
            editTextFields(textField: profileCell.answertf)
            editCellColorDuringEditing(cell: profileCell)
            
            switch indexPath.row  {
            case 0 :
                profileCell.answertf.tag = 0
                profileCell.titleLabel.text = "   Sex"
                if let sex = UserDefaultHelper.manager.getSex(){
                    profileCell.answertf.text = sex
                }
            case 1:
                profileCell.answertf.tag = 1
                profileCell.titleLabel.text = "   Age"
                if let age = UserDefaultHelper.manager.getAge(){
                    profileCell.answertf.text = age
                }
            case 2:
                profileCell.answertf.tag = 2
                profileCell.titleLabel.text = "   Zip Code"
                if let zip = UserDefaultHelper.manager.getZipCode(){
                    profileCell.answertf.text = zip
                }
            default:
                break
            }
            return profileCell
            
        case 1:
            let historyCell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryTableViewCell
            historyCell.answertf.delegate = self
            editTextFields(textField: historyCell.answertf)
            editCellColorDuringEditing(cell: historyCell)
            
            switch indexPath.row  {
            case 0 :
                historyCell.answertf.tag = 3
                historyCell.titleLabel.text = "   Last Menstruation"
                if let lastMentstruation = UserDefaultHelper.manager.getLastPeriod(){
                    historyCell.answertf.text = lastMentstruation
                }
            case 1:
                historyCell.answertf.tag = 4
                historyCell.titleLabel.text = "   Last Sexual Activity"
                if let lastSexualActivity = UserDefaultHelper.manager.getLastSexualActivity(){
                    historyCell.answertf.text = lastSexualActivity
                }
            case 2:
                historyCell.answertf.tag = 5
                historyCell.titleLabel.text = "   Last STD Test"
                if let lastSTDTest = UserDefaultHelper.manager.getLastSTDTest(){
                    historyCell.answertf.text = lastSTDTest
                }
            case 3:
                historyCell.answertf.tag = 6
                historyCell.titleLabel.text = "   Last HIV Test"
                if let lastHIVTest = UserDefaultHelper.manager.getLastHIVTest(){
                    historyCell.answertf.text = lastHIVTest
                }
            default:
                break
            }
            return historyCell
            
        case 2:
            let notesCell = tableView.dequeueReusableCell(withIdentifier: "NotesCell", for: indexPath) as! NotesTableViewCell
            notesCell.notesTextView.delegate = self
            editNotes(notes: notesCell.notesTextView)
            editCellColorDuringEditing(cell: notesCell)
            notesCell.notesTextView.text = UserDefaultHelper.manager.getNotes()
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
            textField.layer.borderWidth = 0.5
            textField.layer.borderColor = Stylesheet.Colors.LightGray.cgColor
            textField.borderStyle = .roundedRect
            textField.textAlignment = .right
        case 0:
            textField.isEnabled = false
            textField.backgroundColor = Stylesheet.Colors.White
            textField.layer.borderWidth = 0.0
            textField.borderStyle = .none
            textField.textAlignment = .right
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
            notes.backgroundColor = Stylesheet.Colors.White
        default:
            break
        }
    }
    
    func editCellColorDuringEditing(cell: UITableViewCell) {
        cell.backgroundColor = Stylesheet.Colors.White
    }
}


extension MyInfoViewController: UITextViewDelegate{
    func textViewDidEndEditing(_ textView: UITextView) {
        let cell = myInfoView.tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as? NotesTableViewCell
        UserDefaultHelper.manager.setNotes(to: (cell?.notesTextView.text)!)
    }
}

extension MyInfoViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            UserDefaultHelper.manager.setSex(to: textField.text!)
        case 1:
            UserDefaultHelper.manager.setAge(to: textField.text!)
        case 2:
            UserDefaultHelper.manager.setZipCode(to: textField.text!)
        case 3:
            UserDefaultHelper.manager.setLastPeriod(to: textField.text!)
        case 4:
            UserDefaultHelper.manager.setLastSexualActivity(to: textField.text!)
        case 5:
            UserDefaultHelper.manager.setLastSTDTest(to: textField.text!)
        case 6:
            UserDefaultHelper.manager.setLastHIVTest(to: textField.text!)
        default:
            break
        }
    }
    
}
