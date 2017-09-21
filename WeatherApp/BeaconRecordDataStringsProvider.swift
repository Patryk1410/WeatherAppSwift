//
//  BeaconRecordDataStringsProvider.swift
//  WeatherApp
//
//  Created by patryk on 20.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation

class BeaconRecordDataStringsProvider {
    
    let data: BeaconRecordData
    
    init(data: BeaconRecordData) {
        self.data = data
    }
    
    func getBeaconDescriptionString() -> String {
        return "Beacon: ".appending(self.data.uuii).appending(", ").appending(self.data.major.description).appending(", ").appending(self.data.minor.description)
    }
    
    func getLocationString() -> String {
        return self.data.city + ", " + self.data.country
    }
    
    func getDateString() -> String {
        return self.data.date
    }
}
