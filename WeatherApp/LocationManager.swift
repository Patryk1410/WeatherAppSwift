//
//  LocationManager.swift
//  WeatherApp
//
//  Created by patryk on 19.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation

class LocationManager: CLLocationManager {
    
    static let instance = LocationManager()
//    var clLocationManager: CLLocationManager?
    
    override init() {
        super.init()
//        self.clLocationManager = CLLocationManager()
        self.allowsBackgroundLocationUpdates = true
    }
    
    func fetchLocation(delegate: CLLocationManagerDelegate) {
        self.delegate = delegate
        if CLLocationManager.locationServicesEnabled() {
            self.desiredAccuracy = kCLLocationAccuracyBest
            self.startUpdatingLocation()
        }
    }
}
