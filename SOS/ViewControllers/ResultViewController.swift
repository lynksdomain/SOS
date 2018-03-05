//
//  ResultViewController.swift
//  SOS
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

protocol FilterDelegate {
    func selectedCategoryChanged()
    func filteredSitesUpdated()
}

class FilteringModel {
    var delegate: FilterDelegate!
    let categories = ["Free", "Walk-In", "Spanish", "Website"]
    var sites: [TestSite]!
    var filteredSites: [TestSite]! {
        didSet {
            delegate.filteredSitesUpdated()
        }
    }
    
    var selectedCategory = Set<String>() {
        didSet {
            let sitesWithFilters = sites!
            filteredSites = filterSites(sitesWithFilters)
            delegate.selectedCategoryChanged()
        }
    }
    
    func saveCategory(_ category: String) {
        if !selectedCategory.contains(category) {
            selectedCategory.insert(category)
        } else {
            selectedCategory.remove(category)
        }
    }
    
    func filterSites(_ sites: [TestSite]) -> [TestSite] {
        var sitesWithFilters = self.sites!
        if selectedCategory.contains("Free") {
            sitesWithFilters = sitesWithFilters.filter({$0.free == Free.yes})
        }
        
        if selectedCategory.contains("Walk-In") {
            sitesWithFilters = sitesWithFilters.filter({ site in
                guard let intake = site.intake else { return false }
                switch intake {
                case .walkInsWelcome:
                    return true
                default:
                    return false
                }
            })
        }
        
        if selectedCategory.contains("Spanish") {
            sitesWithFilters = sitesWithFilters.filter({ site in
                if site.siteLanguages != nil && site.siteLanguages!.contains("Spanish") {
                    return true
                } else {
                    return false
                }
            })
        }
        
        if selectedCategory.contains("Website") {
            sitesWithFilters = sitesWithFilters.filter({ site in
                if site.website != nil {
                    return true
                } else {
                    return false
                }
            })
        }
        return sitesWithFilters
    }
    
}

class ResultViewController: UIViewController {
    let contentView = ResultView()
    let filterModel = FilteringModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = Stylesheet.Colors.MainOrange
        navigationItem.title = "Results"
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        contentView.categoryCollectionView.delegate = self
        contentView.categoryCollectionView.dataSource = self
        filterModel.delegate = self
        prepareContentView()
        configureNavBar()
    }
    
    private func configureNavBar() {
        let textAttributes = [NSAttributedStringKey.foregroundColor: Stylesheet.Colors.MainOrange]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    convenience init(sites: [TestSite]) {
        self.init()
        filterModel.sites = sites
    }
    
    private func prepareContentView() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(view.snp.edges)
        }
    }

}

extension ResultViewController: FilterDelegate {
    func filteredSitesUpdated() {
        dump(filterModel.filteredSites)
    }
    
    func selectedCategoryChanged() {
        contentView.tableView.reloadData()
    }
}

// MARK: - Table View Delegate
extension ResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataSource: [TestSite]!
        if filterModel.selectedCategory.isEmpty {
            dataSource = filterModel.sites
        } else {
            dataSource = filterModel.filteredSites
        }
        
        let site = dataSource[indexPath.row]
//        navigationController?.pushViewController(SiteDetailViewController(site: site), animated: true)
    }
}

// MARK: Table View Data Source
extension ResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dataSource: [TestSite]!
        if filterModel.selectedCategory.isEmpty {
            dataSource = filterModel.sites
        } else {
            dataSource = filterModel.filteredSites
        }
        
        if dataSource.isEmpty {
            tableView.backgroundView = {
                let label = UILabel()
                label.text = "No Test Sites with these parameters"
                label.center = tableView.center
                label.textAlignment = .center
                tableView.separatorStyle = .none
                return label
            }()
        } else {
            tableView.backgroundView = nil
        }
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var site: TestSite!
        if filterModel.selectedCategory.isEmpty {
            site = filterModel.sites[indexPath.row]
        } else {
            site = filterModel.filteredSites[indexPath.row]
        }
        cell.textLabel?.text = site.agencyID
        return cell
    }

}

// MARK: - Collection View Delegate
extension ResultViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
        let category = cell.categoryLabel.text!
        cell.toggleColor()
        filterModel.saveCategory(category)
    }
}

// MARK: - Collection View DataSource
extension ResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
        let category = filterModel.categories[indexPath.row]
        cell.categoryLabel.text = category
        return cell
    }
    
}
