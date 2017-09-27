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
import PromiseKit

class MapProvider: DataProviderProtocol {
    var delegate: DataProviderDelegate?
    
    let weatherManager: WeatherManager = WeatherManagerImpl()
    var location: CLLocationCoordinate2D!
    
    func requestData() {
        firstly {
            self.weatherManager.fetchOneForecast(location: location, context: AERecord.Context.background, shouldUpdateForecast: true)
        }.then { [unowned self] forecast -> () in
            let data = ForecastData(forecast: forecast)
            self.delegate?.didFinishFetching([data])
        }.catch { _ in
            self.delegate?.didFinishFetchingWithError(nil)
        }
    }
}
