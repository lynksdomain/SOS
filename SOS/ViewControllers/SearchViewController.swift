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
    
    var currentSelectedSite: TestSite?
    let filterModel = FilteringModel()
    var currentSelectedLocation: CLLocation?
    
    // GETTING DATA FROM API
    var model = TestSiteDataManager()
    private func getData() {
        let endpoint = "https://data.cityofnewyork.us/resource/fqke-ix7c.json?$limit=20&$where=zip_code!%3D%22%22"
        let endpointQueens = "https://data.cityofnewyork.us/resource/fqke-ix7c.json?$limit=20&$where=zip_code!%3D%22%22&borough=QUEENS"
        model.APIClient.getTestSites(from: endpointQueens, completionHandler: { [weak self] (sites) in
//            self?.model.setTestSites(sites)
            self?.filterModel.sites = sites
            self?.testSites = sites
        }) { (error) in
            print(error)
        }
    }
    
    func filteredSitesUpdated() {
        self.testSites = self.filterModel.filteredSites
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
    
    
    var annotatedSites = [TestSite]()
    var annotatedCoordinates = [CLLocation]()
    var testSites = [TestSite](){
        didSet{
            for site in testSites{
                
                let annotation = MKPointAnnotation()
                let address = "\(site.address!) \(site.zipCode!)"
                
                LocationService.manager.getCityCordinateFromCityName(inputCityName: address, completion: { (location) in
                    
                    if self.searchView.mapView.userLocation.location!.distance(from: location) <= 8046.72{
                        annotation.coordinate = location.coordinate
                        annotation.title = site.siteName
                        self.annotations.append(annotation)
                        self.annotatedSites.append(site)
                        self.annotatedCoordinates.append(location)
                    }
//                    if self.searchView.mapView.isUserLocationVisible == true{
//
//                    }else{
//                        if self.currentLocation.distance(from: location) <= 8046.72{
//                            annotation.coordinate = location.coordinate
//                            annotation.title = site.siteName
//                            self.annotations.append(annotation)
//                        }
//                    }
                    
                    
                }, errorHandler: { (error) in
                    print("annotation error: " + error.localizedDescription)
                })
            }
            print(filterModel.selectedCategory)
            print("annotations:", annotations)
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(searchView)
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = Stylesheet.Colors.MainOrange
        self.searchView.siteSearchBar.delegate = self
        searchView.snp.makeConstraints { (constraint) in
            constraint.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        configureNavBar()
        let authorizationStatus = LocationService.manager.checkForLocationServices()
        authorizationHandling(inputAuthization: authorizationStatus)
        LocationService.manager.delegate = self
        self.searchView.mapView.delegate = self
        self.searchView.categoryCollectionView.delegate = self
        self.searchView.categoryCollectionView.dataSource = self
        self.filterModel.delegate = self
    }
    
    
    
    func authorizationHandling(inputAuthization: CLAuthorizationStatus) {
        if inputAuthization == .authorizedWhenInUse || inputAuthization == .authorizedAlways {
            let currentCLLocation = CLLocation(latitude: UserPreference.manager.getLatitude(), longitude: UserPreference.manager.getLongitude())
            configureMapRegion(from: currentCLLocation)
            self.searchView.mapView.showsUserLocation = true
        }
        
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
        self.navigationController?.pushViewController(ResultViewController(sites: self.testSites), animated: true)
    }
    
}

extension SearchViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let cityName = searchBar.text, searchBar.text != " " else {
            return
        }
        print("THISISTHEONEEEEEE" + cityName)
        LocationService.manager.getCityCordinateFromCityName(inputCityName: cityName, completion: {
            self.currentLocation = $0
            TestSiteAPIClient().getTestSites(from: TestSiteAPIClient.endpoint, completionHandler: { (onlineSites) in
                self.searchView.mapView.removeAnnotations(self.annotations)
                self.annotations.removeAll()
                self.searchView.mapView.showsUserLocation = false
                var lowerBoro: Borough?
                var upperBoro: Borough?
                switch searchBar.text!{
                case "11361", "11362", "11363", "11364","11354", "11355", "11356", "11357", "11358", "11359", "11360","11365", "11366", "11367", "11412", "11423", "11432", "11433", "11434", "11435", "11436", "11101", "11102", "11103", "11104", "11105", "11106", "11374", "11375", "11379", "11385", "11691", "11692", "11693", "11694", "11695", "11697", "11004", "11005", "11411", "11413", "11422", "11426", "11427", "11428", "11429", "11414", "11415", "11416", "11417", "11418", "11419", "11420", "11421", "11368", "11369", "11370", "11372", "11373", "11377", "11378" :
                    lowerBoro = Borough.queens
                    upperBoro = Borough.purpleQueens
                default:
                    print("default")
                    
                }
                var addressSites = onlineSites.filter{$0.address != nil && $0.zipCode != nil && $0.borough != nil}
                self.testSites = addressSites.filter{$0.borough == lowerBoro || $0.borough == upperBoro}
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
            }
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // find place selected
        
        let index = annotations.index{$0 === view.annotation}
        guard let annotationIndex = index else { print("index is nil"); return }
        let site = annotatedSites[annotationIndex]
        currentSelectedSite = site
        currentSelectedLocation = annotatedCoordinates[annotationIndex]
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let vc  = SiteDetailViewController(site: currentSelectedSite!, location: currentSelectedLocation!)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}



extension SearchViewController: LocationDelegate{
    func userDeniedLocation() {
        
        
    }
    
    func userAllowedLocation(with location: CLLocation) {
        configureMapRegion(from: location)
        testSites = model.getTestSites()
        self.searchView.mapView.showsUserLocation = true
        
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
        let category = cell.categoryLabel.text!
        cell.toggleColor()
        filterModel.saveCategory(category)
    }
}

extension SearchViewController: UICollectionViewDataSource {
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

extension SearchViewController: FilterDelegate {
    func selectedCategoryChanged() {
        dump(filterModel.filteredSites)
        self.searchView.mapView.removeAnnotations(self.annotations)
        self.annotations.removeAll()
        self.annotatedSites.removeAll()
        self.testSites = filterModel.filteredSites
    }
}
