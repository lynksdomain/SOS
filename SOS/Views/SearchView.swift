//
//  SearchView.swift
//  SOS
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import MapKit
import SnapKit

class SearchView: UIView {
    
    lazy var siteSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Enter Zip Code"
        
        return searchBar
    }()
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){
        setupMapView()
        
    }
    func setupMapView(){
        addSubview(mapView)
        mapView.snp.makeConstraints { (constraint) in
            constraint.edges.equalTo(snp.edges)
        }
    }

}
