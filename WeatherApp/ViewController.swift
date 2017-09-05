//
//  ViewController.swift
//  WeatherApp
//
//  Created by patryk on 04.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit
import Unbox

class ViewController: UIViewController {

    let lodzLocationId : String = "3093133"
    
    var handler: HttpHandler?
    var forecast: Forecast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.handler = HttpClient(baseURL: "http://api.openweathermap.org/data/")
        let requestById = WeatherByIdRequest(locationId: lodzLocationId)
        let requestByLatAndLon = WeatherByLatitudeAndLongitudeRequest(latitude: "35", longitude: "139")
        
        self.handler?.make(request: requestByLatAndLon, completion: { (result, error) in
            guard let result = result else {
                return
            }
//            print(result)
            do {
                try self.unboxData(result: result)
            } catch {
                print(error)
            }
            
        })
        
        
    }

    func unboxData(result: Dictionary<String, Any>) throws {
        self.forecast = try unbox(dictionary: result)
        print(self.forecast ?? "error")
        self.saveData(forecast: forecast)
    }
    
    func saveData(forecast: Forecast?) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        guard let forecast = forecast else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let weatherRecordMO = WeatherRecordMO(context: managedContext)
        weatherRecordMO.temperature = forecast.weatherRecords[0].temperature
        weatherRecordMO.minTemperature = forecast.weatherRecords[0].minTemperature
        weatherRecordMO.maxTemperature = forecast.weatherRecords[0].maxTemperature
        weatherRecordMO.cloudiness = Int32(forecast.weatherRecords[0].cloudiness)
        weatherRecordMO.conditions = forecast.weatherRecords[0].conditions
        weatherRecordMO.conditionsDescription = forecast.weatherRecords[0].conditionsDescription
        weatherRecordMO.date = forecast.weatherRecords[0].date
        weatherRecordMO.humidity = forecast.weatherRecords[0].humidity
        weatherRecordMO.iconId = forecast.weatherRecords[0].iconId
        weatherRecordMO.pressure = forecast.weatherRecords[0].pressure
        weatherRecordMO.windSpeed = forecast.weatherRecords[0].windSpeed
        
        let locationMO = LocationMO(context: managedContext)
        locationMO.city = forecast.location.city
        locationMO.cityId = forecast.location.cityId
        locationMO.country = forecast.location.country
        
        let forecastMO = ForecastMO(context: managedContext)
        forecastMO.addToWeatherRecords(weatherRecordMO)
        forecastMO.location = locationMO
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

