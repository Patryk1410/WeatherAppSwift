//
//  BeaconRecordData.swift
//  WeatherApp
//
//  Created by patryk on 20.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit

class BeaconRecordData: NSObject, DataObjectProtocol {
    
    let date: String
    let city: String
    let country: String
    let uuii: String
    let major: Int
    let minor: Int
    let weatherRecords: [WeatherRecordMO]
    let forecast: ForecastMO
    
    init(beaconRecord: BeaconRecordMO) {
        self.date = beaconRecord.date ?? noDateError
        self.city = beaconRecord.forecast?.location?.city ?? noCityError
        self.country = beaconRecord.forecast?.location?.country ?? noCountryError
        self.uuii = beaconRecord.uuid ?? generalError
        self.major = NSNumber(value:beaconRecord.major).intValue
        self.minor = NSNumber(value: beaconRecord.minor).intValue
        self.weatherRecords = beaconRecord.forecast?.weatherRecords?.array as? [WeatherRecordMO] ?? []
        self.forecast = beaconRecord.forecast!
    }
    
    func reuseID() -> String {
        return beaconRecordsTableViewCellReuseIdentifier
    }
    
    func height() -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
