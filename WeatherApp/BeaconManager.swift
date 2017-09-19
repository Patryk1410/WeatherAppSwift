//
//  BeaconManager.swift
//  WeatherApp
//
//  Created by patryk on 19.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit
import UserNotifications

class BeaconManager: NSObject, ESTBeaconManagerDelegate {
    
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    let estBeaconManager = ESTBeaconManager()
    let weatherManager: WeatherManager = WeatherManagerImpl()
    var currentRegion: CLBeaconRegion?
    
    override init() {
        super.init()
        self.estBeaconManager.delegate = self
        self.estBeaconManager.requestAlwaysAuthorization()
        self.estBeaconManager.startMonitoring(for: CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, major: 51815, minor: 7365, identifier: "monitored region"))
        NotificationCenter.default.addObserver(self, selector: #selector(reinstateBackgroundTask), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    func beaconManager(_ manager: Any, didEnter region: CLBeaconRegion) {
        self.registerBackgroundTask()
        self.currentRegion = region
        print("Entered region")
        LocationManager.instance.fetchLocation(delegate: self)
    }
    
    func beaconManager(_ manager: Any, didExitRegion region: CLBeaconRegion) {
        print("Left region: \(region.major ?? 0)")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//Background activity
extension BeaconManager {
    
    func registerBackgroundTask() {
        print("Background task started")
        self.backgroundTask = UIApplication.shared.beginBackgroundTask(expirationHandler: { [weak self] in
            print("Error - terminating task")
            self?.endBackgroundTask()
        })
    }
    
    func endBackgroundTask() {
        print("Background task ended")
        UIApplication.shared.endBackgroundTask(backgroundTask)
        self.backgroundTask = UIBackgroundTaskInvalid
    }
    
    func reinstateBackgroundTask() {
//        print("Background task reinstated")
//        if self.backgroundTask == UIBackgroundTaskInvalid {
//            self.registerBackgroundTask()
//        }
    }
}

//Getting current location
extension BeaconManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else {
            return
        }
        print("locations = \(location.latitude) \(location.longitude)")
        self.weatherManager.fetchOneForecast(location: location, completion: { [weak self] (forecast, error) in
            let content = UNMutableNotificationContent()
            guard let region = self?.currentRegion else {
                return
            }
            content.title = "Entered area of \(region.major!) \(region.minor!) beacon"
            content.body = "Current weather in \((forecast?.location?.city)!) is \((forecast?.weatherRecords?.array.first as! WeatherRecordMO).temperature)\(degreesCelcius)"
            let notification = UNNotificationRequest(identifier: "notificationIdentifier", content: content, trigger: nil)
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            UNUserNotificationCenter.current().add(notification, withCompletionHandler: nil)
            self?.endBackgroundTask()
        })
    }
}
