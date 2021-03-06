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
import PromiseKit

protocol WeatherManager {
    func fetchWeather(location: CLLocationCoordinate2D, context: NSManagedObjectContext) -> Promise<[ForecastMO]>
    
    func fetchOneForecast(location: CLLocationCoordinate2D, context: NSManagedObjectContext, shouldUpdateForecast: Bool) -> Promise<ForecastMO>
}
