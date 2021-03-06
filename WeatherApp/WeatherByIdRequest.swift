//
//  WeatherRequest.swift
//  WeatherApp
//
//  Created by patryk on 04.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation

class WeatherByIdRequest: WeatherRequest {
    
    let locationId: String
    
    init(locationId: String) {
        self.locationId = locationId
    }
    
    override func endPoint() -> String {
        return super.endPoint().appending(forecastById).appending(locationId)
            .appending(degreeUnit).appending(celcius)
            .appending(apiKeyUrl).appending(apiKey)
    }
}
