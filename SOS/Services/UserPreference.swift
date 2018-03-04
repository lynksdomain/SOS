//
//  UserPreference.swift
//  SOS
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//


import Foundation
enum UserKeys: String {
    case currentLatitudeKey = "Current Latitude Key"
    case currentLongitudeKey = "Current Longitude Key"
    case currentAddressKey = "Current Address Key"
}

class UserPreference {
    private init(){}
    static let manager = UserPreference()
}

// MARK: Save to defaults functions
extension UserPreference {
    // this function will save a latitude which is a double to the UserDefaults
    public func setLatitude(latitude: Double) {
        UserDefaults.standard.set(latitude, forKey: UserKeys.currentLatitudeKey.rawValue)
    }
    // this function will save a longitude which is a double to the UserDefaults
    public func setLongitude(longitude: Double) {
        UserDefaults.standard.set(longitude, forKey: UserKeys.currentLongitudeKey.rawValue)
    }
    // this function will save a address which is a string to the UserDefaults
    public func setAddress(address: String) {
        UserDefaults.standard.set(address, forKey: UserKeys.currentAddressKey.rawValue)
    }
}

// MARK:- load from defaults function
extension UserPreference {
    // this function will load the latitude from user defaults
    func getLatitude() -> Double {
        guard let latitude = UserDefaults.standard.object(forKey: UserKeys.currentLatitudeKey.rawValue) as? Double else { print("no stored latitude"); return 0.0 }
        return latitude
    }
    // this function will load the longitude from user defaults
    func getLongitude() -> Double {
        guard let longitude = UserDefaults.standard.object(forKey: UserKeys.currentLongitudeKey.rawValue) as? Double else { print("no stored longitude"); return 0.0 }
        return longitude
    }
    // this function will load the address from user defaults
    func getAddress() -> String {
        guard let address = UserDefaults.standard.object(forKey: UserKeys.currentAddressKey.rawValue) as? String else { print("no address found"); return "Queens, NY" }
        return address
    }
}
