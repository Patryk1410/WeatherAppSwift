//
//  WeatherManagerImpl.swift
//  WeatherApp
//
//  Created by patryk on 06.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherManagerImpl: WeatherManager {
    
    let httpHandler: HttpHandler
    let forecastUnboxer: ForecastUnboxer
    
    init() {
        self.httpHandler = HttpClient(baseURL: "")
        self.forecastUnboxer = ForecastUnboxer()
    }
    
    func fetchWeather(location: CLLocationCoordinate2D, completion: @escaping (ForecastMO) -> ()) {
        
    }
}
