//
//  MapProvider.swift
//  WeatherApp
//
//  Created by patryk on 13.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation
import CoreLocation

class MapProvider: ListProviderProtocol {
    var delegate: ListProviderDelegate?
    
    let weatherManager: WeatherManager = WeatherManagerImpl()
    var location: CLLocationCoordinate2D!
    
    func requestData() {
        self.weatherManager.fetchOneForecast(location:location, completion: { [unowned self] (forecast, error) in
            
            guard let forecast = forecast else {
                self.delegate?.didFinishFetchingWithError(nil)
                return
            }
            let data = ForecastData(forecast: forecast)
            
            self.delegate?.didFinishFetching([data])
        })
    }
}
