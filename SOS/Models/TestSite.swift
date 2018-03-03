//
//  TestSite.swift
//  SOS
//
//  Created by C4Q on 3/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

struct TestSite: Codable {
    let address: String?
    let agencyID: String
    let borough: Borough?
    let buildingFloorSuite, city: String?
    let free, lowCost: Free
    let phoneNumber: String?
    let siteID, siteName: String
    let state: State?
    let website, zipCode: String?
    let gendersServed: GendersServed?
    let hoursFriday, hoursMonday, hoursSaturday, hoursSunday: String?
    let hoursThursday, hoursTuesday, hoursWednesday: String?
    let intake: Intake?
    let medicaid: Medicaid?
    let medicare: Medicare?
    let otherInsurances: OtherInsurances?
    let slidingFee: Medicaid?
    let additionalInformation, agesServed, requiredDocuments, briefDescription: String?
    let siteLanguages: String?
    
    enum CodingKeys: String, CodingKey {
        case address
        case agencyID = "agency_id"
        case borough
        case buildingFloorSuite = "building_floor_suite"
        case city, free
        case lowCost = "low_cost"
        case phoneNumber = "phone_number"
        case siteID = "site_id"
        case siteName = "site_name"
        case state, website
        case zipCode = "zip_code"
        case gendersServed = "genders_served"
        case hoursFriday = "hours_friday"
        case hoursMonday = "hours_monday"
        case hoursSaturday = "hours_saturday"
        case hoursSunday = "hours_sunday"
        case hoursThursday = "hours_thursday"
        case hoursTuesday = "hours_tuesday"
        case hoursWednesday = "hours_wednesday"
        case intake, medicaid, medicare
        case otherInsurances = "other_insurances"
        case slidingFee = "sliding_fee"
        case additionalInformation = "additional_information"
        case agesServed = "ages_served"
        case requiredDocuments = "required_documents"
        case briefDescription = "brief_description"
        case siteLanguages = "site_languages"
    }
}

enum Borough: String, Codable {
    case bronx = "BRONX"
    case brooklyn = "BROOKLYN"
    case manhattan = "MANHATTAN"
    case newYork = "NEW YORK"
    case purpleBronx = "Bronx"
    case purpleBrooklyn = "Brooklyn"
    case purpleManhattan = "Manhattan"
    case purpleQueens = "Queens"
    case queens = "QUEENS"
    case statenIsland = "STATEN ISLAND"
}

enum Free: String, Codable {
    case purpleFALSE = "FALSE"
    case purpleTRUE = "TRUE"
}

enum GendersServed: String, Codable {
    case all = "All"
    case femaleAndLGBTQI = "Female and LGBTQI"
    case yes = "Yes"
}

enum Intake: String, Codable {
    case appointmentPreferred = "Appointment preferred"
    case appointmentRequired = "Appointment required"
    case appointmentsPreferred = "Appointments preferred"
    case walkInsWelcome = "Walk-ins welcome"
}

enum Medicaid: String, Codable {
    case yes = "Yes"
}

enum Medicare: String, Codable {
    case no = "No"
    case yes = "Yes"
}

enum OtherInsurances: String, Codable {
    case mostInsurancesAcceptedCopayMayBeApplied = "Most insurances accepted, copay may be applied"
    case noOtherInsurancesAccepted = "No other insurances accepted"
    case someInsurancesAcceptedCopayMayBeApplied = "Some insurances accepted, copay may be applied"
}

enum State: String, Codable {
    case newYork = "New York"
    case ny = "NY"
}
