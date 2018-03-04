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
    
    // GETTING DATA FROM API
    var model = TestSiteDataManager()
    func getData() {
        let endpoint = "https://data.cityofnewyork.us/resource/fqke-ix7c.json?$where=address!%3D%22%22&$limit=20"
        model.APIClient.getTestSites(from: endpoint, completionHandler: { [weak self] (sites) in
            self?.model.setTestSites(sites)
        }) { (error) in
            print(error)
        }
    }

    let searchView = SearchView()
    var currentLocation = CLLocation()
    private var annotations = [MKAnnotation](){
        didSet{
            DispatchQueue.main.async {
            self.searchView.mapView.addAnnotations(self.annotations)
            self.searchView.mapView.showAnnotations(self.annotations, animated: true)
            }
        }
    }
    var testSites = [TestSite](){
        didSet{
            for site in testSites{
                let annotation = MKPointAnnotation()
                let address = "\(site.address!) \(site.zipCode!)"
                LocationService.manager.getCityCordinateFromCityName(inputCityName: address, completion: { (location) in
                    if self.currentLocation.distance(from: location) <= 8046.72{
                    annotation.coordinate = location.coordinate
                    annotation.title = site.siteName
                    self.annotations.append(annotation)
                    }
                }, errorHandler: { (error) in
                    print("annotation error: " + error.localizedDescription)
                })
            }
//            DispatchQueue.main.async {
//                self.searchView.mapView.addAnnotations(self.annotations)
//                self.searchView.mapView.showAnnotations(self.annotations, animated: true)
//
//            }
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
        getData()
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
        self.navigationController?.pushViewController(ResultViewController(sites: model.getTestSites()), animated: true)
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
                   self.currentLocation = $0
//                   self.configureMapRegion(from: self.currentLocation)
            TestSiteAPIClient().getTestSites(from: TestSiteAPIClient.endpoint, completionHandler: { (onlineSites) in
                self.testSites = onlineSites.filter{$0.address != nil && $0.zipCode != nil}
            }, errorHandler: { (testSiteError) in
                print("getting the tests messed up: " + testSiteError.localizedDescription)
            })
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

extension SearchViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        var annotationView = self.searchView.mapView.dequeueReusableAnnotationView(withIdentifier: "PlaceAnnotationView") as? MKMarkerAnnotationView
        if annotationView == nil{
            //Setup annotationView
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "PlaceAnnotationView")
            annotationView?.canShowCallout = true
            let index = annotations.index{$0 === annotation}
            if let annotationIndex = index {
                let site = testSites[annotationIndex]
            }
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        // find place selected
//
//        let index = annotations.index{$0 === view.annotation}
//        guard let annotationIndex = index else { print("index is nil"); return }
//        let site = testSites[annotationIndex]
//        currentSelectedSite = site
//    }
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        let detailVC = VenueDetailedViewController(venue: currentSelectedVenue)
//        navigationController?.pushViewController(detailVC, animated: true)
//    }
}
