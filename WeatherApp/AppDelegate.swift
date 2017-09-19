//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by patryk on 04.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit
import CoreData
import AERecord
import GoogleMaps
import UserNotifications

//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ESTBeaconManagerDelegate {

    var window: UIWindow?
    
    let beaconManager = ESTBeaconManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        print("App did finish launching")
        //Loading initial view controller
        self.window = UIWindow()
        let navigationController = UINavigationController()
        let tabBarViewController = MainTabBarViewController()
        navigationController.viewControllers = [tabBarViewController]
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        //Initializing Core Data Stack with AERecord library
        do {
            try AERecord.loadCoreDataStack()
        } catch {
            print(error)
        }
        
        //Initializing Google Maps
        GMSServices.provideAPIKey(mapApiKey)
        
        //Initializing Estimoto
        ESTConfig.setupAppID(locationApiId, andAppToken: locationApiToken)
        self.beaconManager.delegate = self
        self.beaconManager.requestAlwaysAuthorization()
//        self.beaconManager.startMonitoring(for: CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "monitored region"))
        self.beaconManager.startMonitoring(for: CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, major: 51815, minor: 7365, identifier: "monitored region"))
        
        //Requesting permission for notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {(accepted, error) in
            if !accepted {
                print("Notification access denied.")
            }
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        print("App will resign activity")
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print("App did enter backgroung")
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("App will enter foreground")
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print("App did become active")
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("App will terminate")
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }
    
    func beaconManager(_ manager: Any, didEnter region: CLBeaconRegion) {
        print("Entered region") //works, continue on
        let content = UNMutableNotificationContent()
        content.title = "test"
        content.body = "test"
        let notification = UNNotificationRequest(identifier: "notificationIdentifier", content: content, trigger: nil)
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(notification, withCompletionHandler: nil)
    }
    
    func beaconManager(_ manager: Any, didExitRegion region: CLBeaconRegion) {
        print("Left region: \(region.major ?? 0)")
    }
}

