//
//  BeaconManager.swift
//  WeatherApp
//
//  Created by patryk on 19.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation
import UserNotifications

class BeaconManager: NSObject, ESTBeaconManagerDelegate {
    
    let estBeaconManager = ESTBeaconManager()
    
    override init() {
        super.init()
        self.estBeaconManager.delegate = self
        self.estBeaconManager.requestAlwaysAuthorization()
        self.estBeaconManager.startMonitoring(for: CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, major: 51815, minor: 7365, identifier: "monitored region"))
    }
    
    func beaconManager(_ manager: Any, didEnter region: CLBeaconRegion) {
        print("Entered region") //works, continue on
        let content = UNMutableNotificationContent()
        content.title = "Entered area of \(region.major ?? 0) \(region.minor ?? 0) beacon"
        content.body = "test"
        let notification = UNNotificationRequest(identifier: "notificationIdentifier", content: content, trigger: nil)
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(notification, withCompletionHandler: nil)
    }
    
    func beaconManager(_ manager: Any, didExitRegion region: CLBeaconRegion) {
        print("Left region: \(region.major ?? 0)")
    }
}
