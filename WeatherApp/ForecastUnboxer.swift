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

let weatherRecordsKey = "list"
let locationKey = "city"
let dateKey = "dt_txt"
let temperatureKeyPath = "main.temp"
let minTemperatureKeyPath = "main.temp_min"
let maxTemperatureKeyPath = "main.temp_max"
let pressureKeyPath = "main.pressure"
let humidityKeyPath = "main.humidity"
let conditionsKeyPath = "weather.0.main"
let conditionsDescriptionKeyPath = "weather.0.description"
let iconIdKeyPath = "weather.0.icon"
let cloudinessKeyPath = "clouds.all"
let windSpeedKeyPath = "wind.speed"
let countryKey = "country"
let cityKey = "name"
let cityIdKey = "id"
let fromKey = "list.0.dt_txt"

class ForecastUnboxer: NSObject {
    
    func unbox(dictionary: Dictionary<String, Any>, managedContext: NSManagedObjectContext) throws -> ForecastMO {
        
        let weatherRecordsMO = try self.unboxWeatherRecords(dictionary: dictionary, managedContext: managedContext)
        
        let locationMO: LocationMO = try self.unboxLocation(dictionary: dictionary, managedContext: managedContext)
        
        let forecastMO: ForecastMO = try Unboxer.performCustomUnboxing(dictionary: dictionary, closure: {unboxer in
            
            let fromString: String? = try? unboxer.unbox(key: fromKey)
            let forecastMO: ForecastMO = ForecastMO.firstOrCreate(with: "from", value: fromString ?? "", in: managedContext)
            
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
    
    private func unboxWeatherRecords(dictionary: Dictionary<String, Any>, managedContext: NSManagedObjectContext) throws -> [WeatherRecordMO] {
        var weatherRecordsMO = [WeatherRecordMO]()
        for weatherRecord in (dictionary["list"] as! Array<Any>) {
            let weatherRecordMO: WeatherRecordMO = try Unboxer.performCustomUnboxing(dictionary: weatherRecord as! UnboxableDictionary, closure: {unboxer in
                
                let weatherRecordMO: WeatherRecordMO = WeatherRecordMO(context: managedContext)
                weatherRecordMO.temperature = try unboxer.unbox(keyPath: temperatureKeyPath)
                weatherRecordMO.minTemperature = try unboxer.unbox(keyPath: minTemperatureKeyPath)
                weatherRecordMO.maxTemperature = try unboxer.unbox(keyPath: maxTemperatureKeyPath)
                weatherRecordMO.pressure = try unboxer.unbox(keyPath: pressureKeyPath)
                weatherRecordMO.humidity = try unboxer.unbox(keyPath: humidityKeyPath)
                weatherRecordMO.conditions = unboxer.unbox(keyPath: conditionsKeyPath) ?? "invalid conditions"
                weatherRecordMO.conditionsDescription = unboxer.unbox(keyPath: conditionsDescriptionKeyPath) ?? "invalid description"
                weatherRecordMO.iconId = unboxer.unbox(keyPath: iconIdKeyPath) ?? "invalid icon id"
                weatherRecordMO.cloudiness = try unboxer.unbox(keyPath: cloudinessKeyPath)
                weatherRecordMO.windSpeed = try unboxer.unbox(keyPath: windSpeedKeyPath)
                weatherRecordMO.date = unboxer.unbox(key: dateKey) ?? "invalid date"
                
                return weatherRecordMO
            })
            weatherRecordsMO.append(weatherRecordMO)
        }
        return weatherRecordsMO
    }
    
    private func unboxLocation(dictionary: Dictionary<String, Any>, managedContext: NSManagedObjectContext) throws -> LocationMO {
        let locationMO: LocationMO = try Unboxer.performCustomUnboxing(dictionary: dictionary["city"] as! UnboxableDictionary, closure: {unboxer in
            
            let locationMO: LocationMO = LocationMO(context: managedContext)
            locationMO.country = unboxer.unbox(key: countryKey) ?? "invalid country"
            locationMO.city = unboxer.unbox(key: cityKey) ?? "invalid city"
            locationMO.cityId = unboxer.unbox(key: cityIdKey) ?? "invalid city id"
            
            return locationMO
        })
        return locationMO
    }
}