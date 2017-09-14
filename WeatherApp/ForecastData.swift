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
 This class contains data displayed in Forecasts table view cell
 */
class ForecastData: NSObject, DataObjectProtocol {
    
    
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
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? ForecastData else {
            return false
        }
        return self.forecastDate == object.forecastDate && self.city == object.city && self.country == object.country && self.weatherRecords.elementsEqual(object.weatherRecords)
    }
}
