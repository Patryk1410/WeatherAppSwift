//
//  ForecastRecord.swift
//  WeatherApp
//
//  Created by patryk on 05.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit
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

struct Forecast {
    let weatherRecords: [WeatherRecord]
    let location: Location
}

extension Forecast: Unboxable {
    init(unboxer: Unboxer) throws {
        self.weatherRecords = try unboxer.unbox(key: weatherRecordsKey)
        self.location = try unboxer.unbox(key: locationKey)
    }
}

struct WeatherRecord {
    let date: String
    let temperature: Double
    let minTemperature: Double
    let maxTemperature: Double
    let pressure: Double
    let humidity: Double
    let conditions: String
    let conditionsDescription: String
    let iconId: String
    let cloudiness: Int
    let windSpeed: Double
}

extension WeatherRecord: Unboxable {
    init(unboxer: Unboxer) throws {
        self.date = try unboxer.unbox(key: dateKey)
        self.temperature = try unboxer.unbox(keyPath: temperatureKeyPath)
        self.minTemperature = try unboxer.unbox(keyPath: minTemperatureKeyPath)
        self.maxTemperature = try unboxer.unbox(keyPath: maxTemperatureKeyPath)
        self.pressure = try unboxer.unbox(keyPath: pressureKeyPath)
        self.humidity = try unboxer.unbox(keyPath: humidityKeyPath)
        self.conditions = try unboxer.unbox(keyPath: conditionsKeyPath)
        self.conditionsDescription = try unboxer.unbox(keyPath: conditionsDescriptionKeyPath)
        self.iconId = try unboxer.unbox(keyPath: iconIdKeyPath)
        self.cloudiness = try unboxer.unbox(keyPath: cloudinessKeyPath)
        self.windSpeed = try unboxer.unbox(keyPath: windSpeedKeyPath)
    }
}

struct Location {
    let country: String
    let city: String
    let cityId: String
}

extension Location: Unboxable {
    init(unboxer: Unboxer) throws {
        self.country = try unboxer.unbox(key: countryKey)
        self.city = try unboxer.unbox(key: cityKey)
        self.cityId = try unboxer.unbox(key: cityIdKey)
    }
}
