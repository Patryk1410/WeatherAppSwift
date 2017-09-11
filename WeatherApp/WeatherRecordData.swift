//
//  WeatherRecordData.swift
//  WeatherApp
//
//  Created by patryk on 11.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit

/**
 This class contains data displayed in Forecast table view cell
 */
class WeatherRecordData : TableViewData {
    
    let temperature: String
    let minTemperature: String
    let maxTemperature: String
    let conditions: String
    let conditionsDescription: String
    let date: String
    
    init(weatherRecord: WeatherRecordMO) {
        self.temperature = weatherRecord.temperature.description
        self.minTemperature = weatherRecord.minTemperature.description
        self.maxTemperature = weatherRecord.maxTemperature.description
        self.conditions = weatherRecord.conditions ?? generalError
        self.conditionsDescription = weatherRecord.conditionsDescription ?? generalError
        self.date = weatherRecord.date ?? generalError
    }
    
    func reuseID() -> String {
        return forecastTableViewCellReuseIdentifier
    }
    
    func height() -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
