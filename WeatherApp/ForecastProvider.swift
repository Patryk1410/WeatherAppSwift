//
//  ForecastDataProvider.swift
//  WeatherApp
//
//  Created by patryk on 11.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation

class ForecastProvider: ListProviderProtocol {
    var delegate: ListProviderDelegate?
    
    var forecastData: ForecastData?
    
    func requestData() {
        let weatherRecords = self.forecastData?.weatherRecords
        let data = weatherRecords?.map({ (weatherRecord) in
            return WeatherRecordData(weatherRecord: weatherRecord)
        })
        self.delegate?.didFinishFetching(data)
    }
}
