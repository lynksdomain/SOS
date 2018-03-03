//
//  SearchViewController.swift
//  SOS
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import MapKit

class SearchViewController: UIViewController {

    let searchView = SearchView()
    var currentLocation = CLLocation()
    private var annotations = [MKAnnotation]()
    var testSites = [TestSite](){
        didSet{
            for site in testSites{
                
            let annotation = MKPointAnnotation()
                LocationService.manager.getCityCordinateFromCityName(inputCityName: site.address!, completion: { (location) in
                    annotation.coordinate = location.coordinate
                }, errorHandler: { (error) in
                    print("annotation error: " + error.localizedDescription)
                })
            annotation.title = site.siteName
            annotations.append(annotation)
        }
        DispatchQueue.main.async {
            self.searchView.mapView.addAnnotations(self.annotations)
            self.searchView.mapView.showAnnotations(self.annotations, animated: true)
        }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(searchView)
        self.searchView.siteSearchBar.delegate = self
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
    func configureMapRegion(from inputCLLocation: CLLocation){
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(inputCLLocation.coordinate, span)
        self.searchView.mapView.setRegion(region, animated: true)
    }
    
    
    
    @objc func listNavBarButtonItemAction(){
        //seque to results view controller
        print("it works!")
}
    
}

extension SearchViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
            guard let cityName = searchBar.text, searchBar.text != " " else {
                return
            }
            // this will move the map to a a valid city if not the alert will kick in and notify the user for the error
        LocationService.manager.getCityCordinateFromCityName(inputCityName: cityName, completion: {
                   print($0)
                   self.currentLocation = $0
                   self.configureMapRegion(from: self.currentLocation)
            }, errorHandler: {
                let alert = UIAlertController(title: "Invalid Zip Code, please enter a valid zip code", message: "\($0)", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .default, handler: { (handler) in
                    self.searchView.siteSearchBar.text = ""
                })
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
                
            })
        }
//        if searchBar == self.searchView.venueSearchBar{
//            guard let searchTerm = searchBar.text, searchBar.text != " " else{
//                return
//            }
//            guard self.currentCity != " ", currentCity != "Please Enter your City" else{
//                return
//            }
//            var location = CLLocation(){
//                didSet{
//
//                    self.venues.removeAll()
//                    self.searchView.mapView.removeAnnotations(self.annotations)
//                    self.annotations.removeAll()
//                    VenueAFireAPIClient.manager.getVenues(searchTerm: searchTerm, location: location, completionHandler: {self.venues = $0
//                    }, errorHandler: {print($0)})
//                }
//            }
//            LocationService.manager.getCityCordinateFromCityName(inputCityName: currentCity, completion: {location = $0}, errorHandler: {print($0)})
//
//        }
//    }
}
