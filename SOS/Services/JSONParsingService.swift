//
//  JSONParsingService.swift
//  SOS
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

class JSONParsingService {
    static func parseJSONFile(filename: String, type: String) -> [Fellow]? {
        var fellows: [Fellow]? = nil
        if let pathname = Bundle.main.path(forResource: filename, ofType: type) {
            guard let jsonData = FileManager.default.contents(atPath: pathname) else { return nil }
            do {
                let decoder = JSONDecoder()
                fellows = try decoder.decode([Fellow].self, from: jsonData)
            } catch {
                print("read json error: \(error.localizedDescription)")
            }
        }
        return fellows
    }
}
