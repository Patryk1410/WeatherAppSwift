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
    func unbox(dictionary: [String: Any], managedContext: NSManagedObjectContext) throws -> ForecastMO
}

public class ForecastUnboxer: ForecastUnboxerProtocol {
    
    public func unbox(dictionary: [String: Any], managedContext: NSManagedObjectContext) throws -> ForecastMO{
        
        let weatherRecordsMO = try self.unboxWeatherRecords(dictionary: dictionary, managedContext: managedContext)
        
        let locationMO: LocationMO = try self.unboxLocation(dictionary: dictionary, managedContext: managedContext)
        
        let forecastMO: ForecastMO = try Unboxer.performCustomUnboxing(dictionary: dictionary, closure: {unboxer in
            let forecastMO: ForecastMO = ForecastMO(context: managedContext)
            let list: [Any?] = try unboxer.unbox(key: weatherRecordsKey)
            let elem: [String: Any?]? = list.first as? [String : Any?]
            let date: String? = elem?[dateKey] as? String
            forecastMO.from = date ?? noDateError
            return forecastMO
        })
        
        if let wRecords = forecastMO.weatherRecords{
            forecastMO.removeFromWeatherRecords(wRecords)
        }
        
        for weatherRecord in weatherRecordsMO {
            forecastMO.addToWeatherRecords(weatherRecord)
        }
        forecastMO.location = locationMO
        return forecastMO
    }
    
    private func unboxWeatherRecords(dictionary: [String: Any], managedContext: NSManagedObjectContext) throws -> [WeatherRecordMO] {
        var weatherRecordsMO = [WeatherRecordMO]()
        for weatherRecord in (dictionary["list"] as! Array<Any>) {
            let weatherRecordMO: WeatherRecordMO = try Unboxer.performCustomUnboxing(dictionary: weatherRecord as! UnboxableDictionary, closure: {unboxer in
                
                let weatherRecordMO: WeatherRecordMO = WeatherRecordMO(context: managedContext)
                weatherRecordMO.temperature = try unboxer.unbox(keyPath: temperatureKeyPath)
                weatherRecordMO.minTemperature = try unboxer.unbox(keyPath: minTemperatureKeyPath)
                weatherRecordMO.maxTemperature = try unboxer.unbox(keyPath: maxTemperatureKeyPath)
                weatherRecordMO.pressure = try unboxer.unbox(keyPath: pressureKeyPath)
                weatherRecordMO.humidity = try unboxer.unbox(keyPath: humidityKeyPath)
                weatherRecordMO.conditions = unboxer.unbox(keyPath: conditionsKeyPath) ?? generalError
                weatherRecordMO.conditionsDescription = unboxer.unbox(keyPath: conditionsDescriptionKeyPath) ?? generalError
                weatherRecordMO.iconId = unboxer.unbox(keyPath: iconIdKeyPath) ?? noIconError
                weatherRecordMO.cloudiness = try unboxer.unbox(keyPath: cloudinessKeyPath)
                weatherRecordMO.windSpeed = try unboxer.unbox(keyPath: windSpeedKeyPath)
                weatherRecordMO.date = unboxer.unbox(key: dateKey) ?? noDateError
                
                return weatherRecordMO
            })
            weatherRecordsMO.append(weatherRecordMO)
        }
        return weatherRecordsMO
    }
    
    private func unboxLocation(dictionary: [String: Any], managedContext: NSManagedObjectContext) throws -> LocationMO {
        let locationMO: LocationMO = try Unboxer.performCustomUnboxing(dictionary: dictionary[locationKey] as! UnboxableDictionary, closure: {unboxer in
            
            let locationMO: LocationMO = LocationMO(context: managedContext)
            locationMO.country = unboxer.unbox(key: countryKey) ?? noCountryError
            locationMO.city = unboxer.unbox(key: cityKey) ?? noCityError
            locationMO.cityId = unboxer.unbox(key: cityIdKey) ?? generalError
            
            return locationMO
        })
        return locationMO
    }
}
