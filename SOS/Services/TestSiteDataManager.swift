//
//  TestSiteDataManager.swift
//  SOS
//
//  Created by Masai Young on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

struct TestSiteDataManager {
    private var sites = [TestSite]()
    let APIClient = TestSiteAPIClient()
    
    mutating func setTestSites(_ sites: [TestSite]) {
        self.sites = sites
    }
    
    func getTestSites() -> [TestSite] {
        return self.sites
    }
}
