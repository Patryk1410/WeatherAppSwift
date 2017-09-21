//
//  MapProvider.swift
//  WeatherApp
//
//  Created by patryk on 13.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation
import CoreLocation
import AERecord

class MapProvider: DataProviderProtocol {
    var delegate: DataProviderDelegate?
    
    let weatherManager: WeatherManager = WeatherManagerImpl()
    var location: CLLocationCoordinate2D!
    
    func requestData() {
        self.weatherManager.fetchOneForecast(location:location, context: AERecord.Context.default, shouldUpdateForecast: true, completion: { [unowned self] (forecast, error) in
            
            guard let forecast = forecast else {
                self.delegate?.didFinishFetchingWithError(nil)
                return
            }
            let data = ForecastData(forecast: forecast)
            
            self.delegate?.didFinishFetching([data])
        })
    }
}
