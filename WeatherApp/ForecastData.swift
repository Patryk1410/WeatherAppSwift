//
//  ForecastData.swift
//  WeatherApp
//
//  Created by patryk on 11.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation
import UIKit

/**
 This class contains data displayed in Forecast table view cell
 */
class ForecastData: TableViewData {
    
    
    let forecastDate: String
    let city: String
    let country: String
    let weatherRecords: [WeatherRecordMO]
    
    init(forecast: ForecastMO) {
        self.forecastDate = forecast.from ?? noDateError
        self.city = forecast.location?.city ?? noCityError
        self.country = forecast.location?.country ?? noCountryError
        self.weatherRecords = forecast.weatherRecords?.array as? [WeatherRecordMO] ?? []
    }
    
    func reuseID() -> String {
        return forecastsTableViewCellReuseIdentifier
    }
    func height() -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
