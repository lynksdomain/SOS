//
//  TestSiteAPIClient.swift
//  SOS
//
//  Created by Masai Young on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

struct TestSiteAPIClient {
    static let endpoint = "https://data.cityofnewyork.us/resource/fqke-ix7c.json"
    func getTestSites(from urlStr: String, completionHandler: @escaping ([TestSite]) -> Void, errorHandler: (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        
//        if let cachedImage = ImageCache.manager.getImage(urlStr: urlStr) {
//            completionHandler(cachedImage)
//            return
//        }
        
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let testSites = try JSONDecoder().decode([TestSite].self, from: data)
                completionHandler(testSites)
            }
            catch {
                print(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: URLRequest(url: url),
                                              completionHandler: completion,
                                              errorHandler: {print($0)})
    }
}
