//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by patryk on 06.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation
import CoreLocation


protocol WeatherManager {
    func fetchWeather(location: CLLocationCoordinate2D, completion:@escaping (_ forecast: ForecastMO?, _ error: Error?)->())
}
