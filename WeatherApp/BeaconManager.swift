//
//  BeaconManager.swift
//  WeatherApp
//
//  Created by patryk on 19.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit
import UserNotifications
import AERecord
import CoreData

class BeaconManager: NSObject, ESTBeaconManagerDelegate {
    
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    let estBeaconManager = ESTBeaconManager()
    let weatherManager: WeatherManager = WeatherManagerImpl()
    var currentRegion: CLBeaconRegion?
    var testRegion: CLBeaconRegion?
    
    override init() {
        super.init()
        self.estBeaconManager.delegate = self
        self.estBeaconManager.requestAlwaysAuthorization()
        self.estBeaconManager.startMonitoring(for: CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, major: 51815, minor: 7365, identifier: "monitored region"))
        NotificationCenter.default.addObserver(self, selector: #selector(reinstateBackgroundTask), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        //delete later
        self.currentRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, major: 111, minor: 222, identifier: "testid")
    }
    
    func beaconManager(_ manager: Any, didEnter region: CLBeaconRegion) {
        print("Entered region")
//        self.registerBackgroundTask()
//        self.currentRegion = region
//        LocationManager.instance.fetchLocation(delegate: self)
    }
    
    func beaconManager(_ manager: Any, didExitRegion region: CLBeaconRegion) {
        print("Left region: \(region.major ?? 0)")
    }
    
    func fetchWeather(location: CLLocationCoordinate2D) {
        self.weatherManager.fetchOneForecast(location: location, shouldUpdateForecast: false, completion: { [weak self] (forecast, error) in
            guard let region = self?.currentRegion, let forecast = forecast else {
                self?.endBackgroundTask()
                return
            }
            NotificationManager.instance.sendBeaconNotification(region: region, forecast: forecast)
            self?.createBeaconRecordMO(forecast: forecast)
            self?.endBackgroundTask()
        })
    }
    
    func createBeaconRecordMO(forecast: ForecastMO) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM hh:mm"
        let date = Date()
        _ = ManagedObjectBuilder.instance.buildBeaconRecord(shouldUpdate: false, shouldSave: true, date: formatter.string(from: date), uuid: self.currentRegion?.proximityUUID.description, major: self.currentRegion?.major?.int32Value, minor: self.currentRegion?.minor?.int32Value, forecast: forecast)
        
//        beaconRecord.forecast = context.object(with: forecast.objectID) as! ForecastMO
//        BeaconRecordMO.deleteAll()
//        AERecord.saveAndWait(context: AERecord.Context.background)
//        AERecord.saveAndWait(context: context)
        print("count of records: \(BeaconRecordMO.count())")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//Background activity
extension BeaconManager {
    
    func registerBackgroundTask() {
        print("Background task started")
        ManagedObjectBuilder.instance.context = AERecord.Context.background
        self.backgroundTask = UIApplication.shared.beginBackgroundTask(expirationHandler: { [weak self] in
            print("Error - terminating task")
            self?.endBackgroundTask()
        })
    }
    
    func endBackgroundTask() {
        print("Background task ended")
        ManagedObjectBuilder.instance.context = AERecord.Context.default
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
        if !manager.isKind(of: LocationManager.self) {
            return
        }
        guard let location: CLLocationCoordinate2D = locations.last?.coordinate else {
            self.endBackgroundTask()
            return
        }
        print("locations = \(location.latitude) \(location.longitude)")
        self.fetchWeather(location: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error occurred while fetching location")
    }
}
