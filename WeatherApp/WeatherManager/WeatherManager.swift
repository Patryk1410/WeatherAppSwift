//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by patryk on 06.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation
import CoreLocation
import CoreData

protocol WeatherManager {
    func fetchWeather(location: CLLocationCoordinate2D, context: NSManagedObjectContext, completion:@escaping (_ forecast: [ForecastMO]?, _ error: Error?)->())
    
    func fetchOneForecast(location: CLLocationCoordinate2D, context: NSManagedObjectContext, shouldUpdateForecast: Bool, completion:@escaping (_ forecast: ForecastMO?, _ error: Error?) -> ())
}
