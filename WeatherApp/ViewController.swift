//
//  ViewController.swift
//  WeatherApp
//
//  Created by patryk on 04.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit
import Unbox
import CoreData

class ViewController: UIViewController {

    var appDelegate: AppDelegate?
    
    let lodzLocationId : String = "3093133"
    
    var handler: HttpHandler?
    var forecast: Forecast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
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
        
        let managedContext = appDelegate!.persistentContainer.viewContext
        let weatherRecordMO = WeatherRecordMO(context: managedContext)
        
        print(self.forecast ?? "error")
        
        self.saveData(forecast: forecast)
    }
    
    func saveData(forecast: Forecast?) {
//        guard self.appDelegate = UIApplication.shared.delegate as! AppDelegate else {
//            return
//        }
        
        guard let forecast = forecast else {
            return
        }
        
        let managedContext = appDelegate!.persistentContainer.viewContext
        
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
        
        do {
            try managedContext.save()
        } catch {
            print("could not save \(error)")
        }
        
    }
    
    @IBAction func fetch(_ sender: Any) {
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Forecast")
        
        do {
            let forecasts: [ForecastMO] = try managedContext.fetch(fetchRequest) as! [ForecastMO]
            print(forecasts)
        } catch {
            print("could not fetch \(error)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

