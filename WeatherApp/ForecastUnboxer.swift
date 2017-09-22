//
//  ForecastUnboxer.swift
//  WeatherApp
//
//  Created by patryk on 06.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit
import CoreData
import Unbox

public protocol ForecastUnboxerProtocol{
    func unbox(dictionary: [String: Any], shouldSaveForecast: Bool, shouldUpdateForecast: Bool, context: NSManagedObjectContext) throws -> ForecastMO
}

public class ForecastUnboxer: ForecastUnboxerProtocol {
    
    public func unbox(dictionary: [String: Any], shouldSaveForecast: Bool, shouldUpdateForecast: Bool, context: NSManagedObjectContext) throws -> ForecastMO {
        
        let builder: ManagedObjectBuilder = ManagedObjectBuilder(context: context)
        
        let weatherRecordsMO = try self.unboxWeatherRecords(dictionary: dictionary, builder: builder)
        
        let locationMO: LocationMO = try self.unboxLocation(dictionary: dictionary, builder: builder)
        
        let forecastMO: ForecastMO = try Unboxer.performCustomUnboxing(dictionary: dictionary, closure: {unboxer in
            let list: [Any?] = try unboxer.unbox(key: weatherRecordsKey)
            let elem: [String: Any?]? = list.first as? [String : Any?]
            let date: String? = elem?[dateKey] as? String
            let from = date
            let cityId = locationMO.cityId
            return builder.buildForecast(shouldUpdate: shouldUpdateForecast,
                                         from: from,
                                         cityId: cityId,
                                         weatherRecords: weatherRecordsMO,
                                         location: locationMO)
        })
        if shouldSaveForecast {
            builder.saveChangesAndWait()
        }
        return forecastMO
    }
    
    private func unboxWeatherRecords(dictionary: [String: Any], builder: ManagedObjectBuilder) throws -> [WeatherRecordMO] {
        var weatherRecordsMO = [WeatherRecordMO]()
        for weatherRecord in (dictionary["list"] as! Array<Any>) {
            let weatherRecordMO: WeatherRecordMO = try Unboxer.performCustomUnboxing(dictionary: weatherRecord as! UnboxableDictionary, closure: {unboxer in
                let temperature: Double? = unboxer.unbox(keyPath: temperatureKeyPath)
                let minTemperature: Double? = unboxer.unbox(keyPath: minTemperatureKeyPath)
                let maxTemperature: Double? = unboxer.unbox(keyPath: maxTemperatureKeyPath)
                let pressure: Double? = unboxer.unbox(keyPath: pressureKeyPath)
                let humidity: Double? = unboxer.unbox(keyPath: humidityKeyPath)
                let conditions = unboxer.unbox(keyPath: conditionsKeyPath) ?? generalError
                let conditionsDescription = unboxer.unbox(keyPath: conditionsDescriptionKeyPath) ?? generalError
                let iconId = unboxer.unbox(keyPath: iconIdKeyPath) ?? noIconError
                let cloudiness: Int32? = unboxer.unbox(keyPath: cloudinessKeyPath)
                let windSpeed: Double? = unboxer.unbox(keyPath: windSpeedKeyPath)
                let date = unboxer.unbox(key: dateKey) ?? noDateError
                return builder.buildWeatherRecord(temperature: temperature,
                                                  minTemperature: minTemperature,
                                                  maxTemperature: maxTemperature,
                                                  pressure: pressure,
                                                  humidity: humidity,
                                                  conditions: conditions,
                                                  conditionsDescription: conditionsDescription,
                                                  iconId: iconId,
                                                  cloudiness: cloudiness,
                                                  windSpeed: windSpeed, date: date)
            })
            weatherRecordsMO.append(weatherRecordMO)
        }
        return weatherRecordsMO
    }
    
    private func unboxLocation(dictionary: [String: Any], builder: ManagedObjectBuilder) throws -> LocationMO {
        let locationMO: LocationMO = try Unboxer.performCustomUnboxing(dictionary: dictionary[locationKey] as! UnboxableDictionary, closure: {unboxer in
            let country: String? = unboxer.unbox(key: countryKey)
            let city: String? = unboxer.unbox(key: cityKey)
            let cityId: String? = unboxer.unbox(key: cityIdKey)
            return builder.buildLocation(shouldUpdate: false,
                                         country: country,
                                         city: city,
                                         cityId: cityId)
        })
        return locationMO
    }
}
