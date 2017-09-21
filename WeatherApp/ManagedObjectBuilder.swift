//
//  ManagedObjectBuilder.swift
//  WeatherApp
//
//  Created by patryk on 20.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation
import CoreData
import AERecord

class ManagedObjectBuilder: NSObject {
    
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func buildLocation(shouldUpdate: Bool, country: String?, city: String?, cityId: String?) -> LocationMO {
        let pred = NSPredicate(format: "cityId == %@", cityId ?? "")
        if let res = self.checkIfShoulUpdate(type: LocationMO.self, pred: pred, shouldUpdate: shouldUpdate) {
            return res as! LocationMO
        }
        
        let locationMO: LocationMO = LocationMO(context: self.context)
        locationMO.country = country ?? noCountryError
        locationMO.city = city ?? noCityError
        locationMO.cityId = cityId ?? generalError
        return locationMO
    }
    
    func buildWeatherRecord(temperature: Double?, minTemperature: Double?, maxTemperature: Double?, pressure: Double?, humidity: Double?, conditions: String?, conditionsDescription: String?, iconId: String?, cloudiness: Int32?, windSpeed: Double?, date: String?) -> WeatherRecordMO {
        let weatherRecordMO: WeatherRecordMO = WeatherRecordMO(context: self.context)
        weatherRecordMO.temperature = temperature ?? 0.0
        weatherRecordMO.minTemperature = minTemperature ?? 0.0
        weatherRecordMO.maxTemperature = maxTemperature ?? 0.0
        weatherRecordMO.pressure = pressure ?? 0.0
        weatherRecordMO.humidity = humidity ?? 0.0
        weatherRecordMO.conditions = conditions ?? generalError
        weatherRecordMO.conditionsDescription = conditionsDescription ?? generalError
        weatherRecordMO.iconId = iconId ?? noIconError  
        weatherRecordMO.cloudiness = cloudiness ?? 0
        weatherRecordMO.windSpeed = windSpeed ?? 0.0
        weatherRecordMO.date = date ?? noDateError
        return weatherRecordMO
    }
    
    func buildForecast(shouldUpdate: Bool, shouldSave: Bool, from: String?, cityId: String?, weatherRecords: [WeatherRecordMO], location: LocationMO) -> ForecastMO {
//        beaconRecord.forecast = context.object(with: forecast.objectID) as! ForecastMO
        let pred = NSPredicate(format: "from == %@ AND cityId == %@", from ?? "", cityId ?? "")
        if let res = self.checkIfShoulUpdate(type: ForecastMO.self, pred: pred, shouldUpdate: shouldUpdate) {
            return res as! ForecastMO
        }
        
        let forecastMO: ForecastMO = ForecastMO(context: self.context)
        forecastMO.from = from ?? noDateError
        forecastMO.cityId = cityId ?? ""
        forecastMO.location = location
        for weatherRecord in weatherRecords {
            forecastMO.addToWeatherRecords(weatherRecord)
        }
        if shouldSave {
            AERecord.saveAndWait(context: context)
        }
        return forecastMO
    }
    
    func buildBeaconRecord(shouldUpdate: Bool, shouldSave: Bool, date: String?, uuid: String?, major: Int32?, minor: Int32?, forecast: ForecastMO?) -> BeaconRecordMO {
        let pred = NSPredicate(format: "date == %@ AND uuid == %@ AND major == %@ AND minor == %@", date ?? "", uuid ?? "", NSNumber(value: major ?? 0), NSNumber(value: minor ?? 0))
        if let res = self.checkIfShoulUpdate(type: BeaconRecordMO.self, pred: pred, shouldUpdate: shouldUpdate) {
            return res as! BeaconRecordMO
        }
        
        let beaconRecordMO: BeaconRecordMO = BeaconRecordMO(context: self.context)
        beaconRecordMO.date = date ?? noDateError
        beaconRecordMO.uuid = uuid ?? generalError
        beaconRecordMO.major = major ?? 0
        beaconRecordMO.minor = minor ?? 0
        beaconRecordMO.forecast = forecast
        if shouldSave {
            AERecord.saveAndWait(context: self.context)
        }
        return beaconRecordMO
    }
    
    func checkIfShoulUpdate<T: NSManagedObject>(type: T.Type, pred: NSPredicate, shouldUpdate: Bool) -> NSManagedObject? {
        if (T.count(with: pred, in: self.context)) > 0 {
            if shouldUpdate {
                T.deleteAll(with: pred, from: self.context)
            } else {
                return T.first(with: pred, in: self.context)!
            }
        }
        return nil
    }
}
