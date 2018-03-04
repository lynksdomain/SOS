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
    
    lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let cellSpacing = UIScreen.main.bounds.width * 0.02
        let numberOfCells: CGFloat = 1
        let numberOfSpaces: CGFloat = numberOfCells + 1
        layout.itemSize = CGSize(width: (screenWidth - (cellSpacing * numberOfSpaces)) * 0.25 / numberOfCells, height: screenHeight * 0.12)
        layout.sectionInset = UIEdgeInsetsMake(cellSpacing, cellSpacing, cellSpacing, cellSpacing)
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = Stylesheet.Colors.LightPink
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCell")
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){
        setupCategoryToolbar()
        setupMapView()
        
    }
    func setupCategoryToolbar() {
        addSubview(categoryCollectionView)
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.height.equalTo(snp.height).dividedBy(8)
        }
    }
    func setupMapView(){
        addSubview(mapView)
        mapView.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(categoryCollectionView.snp.bottom)
            constraint.left.equalTo(snp.left)
            constraint.right.equalTo(snp.right)
            constraint.bottom.equalTo(snp.bottom)
        }
    }

}
