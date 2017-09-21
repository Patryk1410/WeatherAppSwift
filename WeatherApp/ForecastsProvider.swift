//
//  ForecastsProvider.swift
//  WeatherApp
//
//  Created by patryk on 11.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation
import CoreLocation
import AERecord

class ForecastsProvider: DataProviderProtocol {
    var delegate: DataProviderDelegate?
    var weatherManager: WeatherManager
    
    init() {
        self.weatherManager = WeatherManagerImpl()
    }
    
    func requestData() {
        let locationWarsaw = CLLocationCoordinate2D(latitude: 52.21, longitude: 21.01)
        let context = AERecord.Context.default
        self.weatherManager.fetchWeather(location:locationWarsaw, context: context, completion: { [unowned self] (forecasts, error) in
            
            guard let forecasts = forecasts else {
                self.delegate?.didFinishFetchingWithError(nil)
                return
            }
            let filteredForecasts = forecasts.filter() { (forecast) in
                return forecast.beaconRecords?.count == 0
            }
            let data = filteredForecasts.map({ (forecast) -> ForecastData in
                return ForecastData(forecast: forecast)
            })
            
            self.delegate?.didFinishFetching(data)
        })
    }
}
