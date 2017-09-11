//
//  File.swift
//  WeatherApp
//
//  Created by patryk on 11.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation

/**
 This class is responsible for creating strings from WeatherRecordData for labels in table view cell
 */
class WeatherRecordDataStringsProvider {
    
    let data: WeatherRecordData
    
    init(data: WeatherRecordData) {
        self.data = data
    }
    
    func getTemperatureString() -> String {
        return self.data.temperature + degreesCelcius
    }
    
    func getMinTemperatureString() -> String {
        return minStr + self.data.minTemperature + degreesCelcius
    }
    
    func getMaxTemperatureString() -> String {
        return maxStr + self.data.maxTemperature + degreesCelcius
    }
    
    func getDateString() -> String {
        return self.data.date
    }
    
    func getConditionsString() -> String {
        return self.data.conditions
    }
    
    func getConditionsDescriptionString() -> String {
        return self.data.conditionsDescription
    }
    
    func getWeatherIconUrl() -> String {
        return baseURL + iconUrl + self.data.iconId + pngExtension
    }
}
