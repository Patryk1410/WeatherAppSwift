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
import PromiseKit

class ForecastsProvider: DataProviderProtocol {
    var delegate: DataProviderDelegate?
    var weatherManager: WeatherManager
    
    init() {
        self.weatherManager = WeatherManagerImpl()
    }
    
    func requestData() {
        let locationWarsaw = CLLocationCoordinate2D(latitude: 52.21, longitude: 21.01)
        let context = AERecord.Context.background
        firstly {
            self.weatherManager.fetchWeather(location: locationWarsaw, context: context)
        }.then { [unowned self] forecasts -> () in
            let filteredForecasts = forecasts.filter() { (forecast) in
                return forecast.beaconRecords?.count == 0
            }
            let data = filteredForecasts.map({ (forecast) -> ForecastData in
                return ForecastData(forecast: forecast)
            })
            self.delegate?.didFinishFetching(data)
        }.catch { _ in
            self.delegate?.didFinishFetchingWithError(nil)
        }
    }
}
