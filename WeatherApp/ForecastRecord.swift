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
let dateKey = "dt"
let temperatureKey = "main.temp"
let minTemperatureKey = "main.temp_min"
let maxTemperatureKey = "main.temp_max"
let pressureKey = "main.pressure"
let humidityKey = "main.humidity"
let conditionsKey = "weather.main"
let conditionsDescriptionKey = "weather.description"
let iconIdKey = "weather.icon"
let cloudinessKey = "clouds.all"
let windSpeedKey = "wind.speed"
let countryKey = "country"
let cityKey = "name"
let cityIdKey = "id"

struct ForecastRecord {
    let weatherRecords: [WeatherRecord]
    let location: Location
}

extension ForecastRecord: Unboxable {
    init(unboxer: Unboxer) throws {
        self.weatherRecords = try unboxer.unbox(key: weatherRecordsKey)
        self.location = try unboxer.unbox(key: locationKey)
    }
}

struct WeatherRecord {
    let date: Date?
    let temperature: Double
    let minTemperature: Double
    let maxTemperature: Double
    let pressure: Double
    let humidity: Double
    let conditions: String
    let conditionsDescription: Int
    let iconId: String
    let cloudiness: Int
    let windSpeed: Double
}

extension WeatherRecord: Unboxable {
    init(unboxer: Unboxer) throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm"
        self.date = unboxer.unbox(key: dateKey, formatter: dateFormatter)
        self.temperature = try unboxer.unbox(key: temperatureKey)
        self.minTemperature = try unboxer.unbox(key: minTemperatureKey)
        self.maxTemperature = try unboxer.unbox(key: maxTemperatureKey)
        self.pressure = try unboxer.unbox(key: pressureKey)
        self.humidity = try unboxer.unbox(key: humidityKey)
        self.conditions = try unboxer.unbox(key: conditionsKey)
        self.conditionsDescription = try unboxer.unbox(key: conditionsDescriptionKey)
        self.iconId = try unboxer.unbox(key: iconIdKey)
        self.cloudiness = try unboxer.unbox(key: cloudinessKey)
        self.windSpeed = try unboxer.unbox(key: windSpeedKey)
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
