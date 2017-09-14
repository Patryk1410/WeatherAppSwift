//
//  ForecastDataStringsProvider.swift
//  WeatherApp
//
//  Created by patryk on 11.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation

/** 
 This class is responsible for creating strings from ForecastData for labels in table view cell
 */
class ForecastDataStringsProvider {
    
    let data: ForecastData
    
    init(data: ForecastData) {
        self.data = data
    }
    
    func getLocationString() -> String {
        return self.data.city + ", " + self.data.country
    }
    
    func getDateString() -> String {
        return self.data.forecastDate
    }
    
    func getCurrentTemperatureString() -> String {
        return (self.data.weatherRecords.first?.temperature.description ?? "-") + degreesCelcius
    }
}
