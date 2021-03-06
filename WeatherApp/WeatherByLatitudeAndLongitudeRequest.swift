//
//  WeatherByLatitudeAndLongitudeRequest.swift
//  WeatherApp
//
//  Created by patryk on 05.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation

class WeatherByLatitudeAndLongitudeRequest: WeatherRequest {
    
    let latitude: String
    let longitude: String
    
    init(latitude: String, longitude: String) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    override func endPoint() -> String {
        return super.endPoint()
            .appending(forecastByLatAndLong).appending(latitude)
            .appending(longUrl).appending(longitude)
            .appending(degreeUnit).appending(celcius)
            .appending(apiKeyUrl).appending(apiKey)
    }
}
