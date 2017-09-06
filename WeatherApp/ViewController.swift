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
import AERecord

class ViewController: UIViewController {

    
    var weatherManager: WeatherManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.weatherManager = WeatherManagerImpl()
        let location = CLLocationCoordinate2D(latitude: 19.4123, longitude: 52.2321)
        
        self.weatherManager?.fetchWeather(location:location, completion: { (forecast) in
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

