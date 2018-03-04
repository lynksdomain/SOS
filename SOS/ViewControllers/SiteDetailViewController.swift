//
//  SiteDetailViewController.swift
//  SOS
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import MapKit
import TableFlip

class SiteDetailViewController: UIViewController {
    
    let contentView = SiteDetailView()
    var site: TestSite!
    var sections: [[String]]!
    var titles: [[String]]!
    var location: CLLocation!
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareContentView()
        prepareDelegates()
        dump(site.location)
    }

    convenience init(site: TestSite, location: CLLocation) {
        self.init()
        self.site = site
        self.location = location
        sections = [site.siteInfo, site.location, site.contact, site.hours, site.cost]
        titles = [site.siteInfoTitles, site.locationTitles, site.contactTitles, site.hoursTitles, site.costTitles]
    }
    
    private func prepareContentView() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(view.snp.edges)
        }

    }
    
    private func prepareDelegates() {
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
    }
}

extension SiteDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let titles = ["Name", "Location", "Contact", "Hours", "Cost"]
        return titles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = Stylesheet.Colors.LightPink
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
}

extension SiteDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let siteCategory = Array(site.detailDict.keys)[section]
        let categoryDict = site.detailDict[siteCategory]!
        let onlyPresentFields = Array(categoryDict.values.flatMap({$0}))
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        
//        let siteCategory = Array(site.detailDict.keys)[indexPath.section]
//        let categoryDict = site.detailDict[siteCategory]
//        let categoryKeys = Array(categoryDict!.keys)
//        let key = categoryKeys[indexPath.row]
//        let value = categoryDict![key] ?? "Mistake"
        
        
        let data = sections[indexPath.section][indexPath.row]
        let title = titles[indexPath.section][indexPath.row]
        if indexPath.section == 1{
            if indexPath.row == 0{
                cell.textLabel?.textColor = UIColor.blue
            }
        }
        cell.textLabel?.text = title + "  :  " + data
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            switch indexPath.row{
            case 0:
                guard UserPreference.manager.getLongitude() != 0, UserPreference.manager.getLatitude() != 0 else {
                    return
                }
                let userCoordinate = CLLocationCoordinate2DMake(UserPreference.manager.getLatitude(), UserPreference.manager.getLongitude())
                let placeCoordinate = location.coordinate
                
                let directionsURLString = "http://maps.apple.com/?saddr=\(userCoordinate.latitude),\(userCoordinate.longitude)&daddr=\(placeCoordinate.latitude),\(placeCoordinate.longitude)"
                UIApplication.shared.open(URL(string: directionsURLString)!, options: [:]) { (done) in
                    print("launched apple maps")
                }
            default:
                print("these are not the rows you're looking for")
            }
        default:
            print("these are not the sections you're looking for")
        }
    }
    
    
}
