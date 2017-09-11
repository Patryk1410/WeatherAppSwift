//
//  ForecastsProvider.swift
//  WeatherApp
//
//  Created by patryk on 11.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation
import CoreLocation

class ForecastsProvider: ListProviderProtocol {
    var delegate: ListProviderDelegate?
    var weatherManager: WeatherManager
    
    init() {
        self.weatherManager = WeatherManagerImpl()
    }
    
    func requestData() {
        let locationWarsaw = CLLocationCoordinate2D(latitude: 52.21, longitude: 21.01)
        
        self.weatherManager.fetchWeather(location:locationWarsaw, completion: { [unowned self] (forecasts, error) in
            
            guard let forecasts = forecasts else {
                self.delegate?.didFinishFetchingWithError(nil)
                return
            }
            let data = forecasts.map({ (forecast) -> ForecastData in
                return ForecastData(forecast: forecast)
            })
            
            self.delegate?.didFinishFetching(data)
        })
    }
}
