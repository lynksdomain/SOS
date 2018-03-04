//
//  UserDefaultsHelper.swift
//  SOS
//
//  Created by Ashlee Krammer on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

struct UserDefaultHelper {
    static let manager = UserDefaultHelper()
    private init() {}
    
    //Users Sex
    let sexKey = "sexKey"
    func getSex() -> String? {
        return UserDefaults.standard.string(forKey: sexKey)
    }
    func setSex(to thisTF: String) {
        UserDefaults.standard.setValue(thisTF, forKey: sexKey)
    }
    
    //Users Age
    let ageKey = "ageKey"
    func getAge() -> String? {
        return UserDefaults.standard.string(forKey: ageKey)
    }
    func setAge(to thisTF: String) {
        UserDefaults.standard.setValue(thisTF, forKey: ageKey)
    }
    
    //Users Zip Code
    let zipcodeKey = "zipcodeKey"
    func getZipCode() -> String? {
        return UserDefaults.standard.string(forKey: zipcodeKey)
    }
    func setZipCode(to thisTF: String) {
        UserDefaults.standard.setValue(thisTF, forKey: zipcodeKey)
    }
    
    //Recent Menstration
    let lastPeriodKey = "lastPeriodKey"
    func getLastPeriod() -> String? {
        return UserDefaults.standard.string(forKey: lastPeriodKey)
    }
    func setLastPeriod(to thisTF: String) {
        UserDefaults.standard.setValue(thisTF, forKey: lastPeriodKey)
    }
    
    //Recent Sexual Activity
    let lastSexualActivityKey = "lastSexualActivityKey"
    func getLastSexualActivity() -> String? {
        return UserDefaults.standard.string(forKey: lastSexualActivityKey)
    }
    func setLastSexualActivity(to thisTF: String) {
        UserDefaults.standard.setValue(thisTF, forKey: lastSexualActivityKey)
    }
    
    //Recent STD Test
    let lastSTDTestKey = "lastSTDTestKey"
    func getLastSTDTest() -> String? {
        return UserDefaults.standard.string(forKey: lastSTDTestKey)
    }
    func setLastSTDTest(to thisTF: String) {
        UserDefaults.standard.setValue(thisTF, forKey: lastSTDTestKey)
    }
    
    //Recent HIV Test
    let lastHIVTestKey = "lastHIVTestKey"
    func getLastHIVTest() -> String? {
        return UserDefaults.standard.string(forKey: lastHIVTestKey)
    }
    func setLastHIVTest(to thisTF: String) {
        UserDefaults.standard.setValue(thisTF, forKey: lastHIVTestKey)
    }
    
    //Notes
    let notesKey = "notesKey"
    func getNotes() -> String? {
        return UserDefaults.standard.string(forKey: notesKey)
    }
    func setNotes(to thisTF: String) {
        UserDefaults.standard.setValue(thisTF, forKey: notesKey)
    }
    
}

