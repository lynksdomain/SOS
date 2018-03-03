//
//  SearchViewController.swift
//  SOS
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    let searchView = SearchView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(searchView)
        searchView.snp.makeConstraints { (constraint) in
            constraint.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        configureNavBar()
    }

    func configureNavBar(){
        let listNavBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Menu"), style: .plain, target: self, action: #selector(listNavBarButtonItemAction))
        navigationItem.rightBarButtonItem = listNavBarButtonItem
        navigationItem.titleView = searchView.siteSearchBar
        navigationController?.navigationBar.barTintColor = UIColor.white

      
    }
    
    
    
    @objc func listNavBarButtonItemAction(){
        //seque to results view controller
        print("it works!")
}
    
}
