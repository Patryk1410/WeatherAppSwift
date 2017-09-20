//
//  NotificationManager.swift
//  WeatherApp
//
//  Created by patryk on 19.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationManager: NSObject {
    
    static let instance = NotificationManager()
    
    func sendBeaconNotification(region: CLBeaconRegion, forecast: ForecastMO) {
        let content = UNMutableNotificationContent()
        let forecastData = ForecastData(forecast: forecast)
        let stringsProvider = ForecastDataStringsProvider(data: forecastData)
        content.title = "Entered area of \(region.major!) \(region.minor!) beacon"
        content.body = "Current weather in \(stringsProvider.getLocationString()) is \(stringsProvider.getCurrentTemperatureString())"
        let notification = UNNotificationRequest(identifier: "notificationIdentifier", content: content, trigger: nil)
        self.sendNotification(notification: notification)
    }
    
    private func sendNotification(notification: UNNotificationRequest) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(notification, withCompletionHandler: nil)
    }
}
