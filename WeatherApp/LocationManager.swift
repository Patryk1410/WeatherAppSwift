//
//  LocationManager.swift
//  WeatherApp
//
//  Created by patryk on 19.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation

class LocationManager: NSObject {
    
    static let instance = LocationManager()
    var clLocationManager: CLLocationManager?
    
    override init() {
        super.init()
        self.clLocationManager = CLLocationManager()
        self.clLocationManager?.allowsBackgroundLocationUpdates = true
    }
    
    func fetchLocation(delegate: CLLocationManagerDelegate) {
        self.clLocationManager?.delegate = delegate
        if CLLocationManager.locationServicesEnabled() {
            clLocationManager?.desiredAccuracy = kCLLocationAccuracyBest
            clLocationManager?.startUpdatingLocation()
        }
    }
}
