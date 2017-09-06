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
import CoreLocation

class ViewController: UIViewController {

    var appDelegate: AppDelegate?
    var managedContext: NSManagedObjectContext?
    
    let lodzLocationId : String = "3093133"
    
    var handler: HttpHandler?
    var weatherManager: WeatherManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.weatherManager = WeatherManagerImpl()
        let location = CLLocationCoordinate2D(latitude: 19.4123, longitude: 52.2321)
        
        self.weatherManager?.fetchWeather(location:location, completion: { (forecast) in
            
        })
        
        
        
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.managedContext = appDelegate!.persistentContainer.viewContext
        self.managedContext?.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        self.handler = HttpClient(baseURL: "http://api.openweathermap.org/data/")
        let requestById = WeatherByIdRequest(locationId: lodzLocationId)
        let requestByLatAndLon = WeatherByLatitudeAndLongitudeRequest(latitude: "35", longitude: "139")
        
//        self.clearDatabase()
        
        self.handler?.make(request: requestByLatAndLon, completion: { (result, error) in
            guard let result = result else {
                return
            }
            do {
                try self.unboxData(result: result)
            } catch {
                print("Error occurred while unboxing: \(error)")
            }
            
        })
        
        
    }

    func unboxData(result: Dictionary<String, Any>) throws {
        
        guard let managedContext = self.managedContext else {
            return
        }
        
        try ForecastUnboxer.sharedInstance.unbox(dictionary: result, managedContext: managedContext)
        
        self.saveData()
    }
    
    func saveData() {
        guard let managedContext = self.managedContext else {
            return
        }
        
        do {
            try managedContext.save()
        } catch {
            print("could not save \(error)")
        }
    }
    
    @IBAction func fetch(_ sender: Any) {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Forecast")
        
        guard let managedContext = self.managedContext else {
            return
        }
        
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
    
    func clearDatabase() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Forecast")
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try self.managedContext?.execute(batchDeleteRequest)
        } catch {
            
        }
    }


}

