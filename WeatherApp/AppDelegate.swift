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
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var beaconManager: BeaconManager!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        print("App did finish launching")
        
        
        //Initializing Core Data Stack with AERecord library
        do {
            try AERecord.loadCoreDataStack()
//            let pred = NSPredicate(format: "from == %@ AND cityId == %@", "2017-09-21 12:00:00", "756135")
//            ForecastMO.deleteAll(with: pred)
//            AERecord.saveAndWait()
        } catch {
            print(error)
        }
        
        //Initializing Google Maps
        GMSServices.provideAPIKey(mapApiKey)
        
        //Initializing Estimoto
        ESTConfig.setupAppID(locationApiId, andAppToken: locationApiToken)
        self.beaconManager = BeaconManager()
        
        //Requesting permission for notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {(accepted, error) in
            if !accepted {
                print("Notification access denied.")
            }
        }
        
        //Loading initial view controller
        self.window = UIWindow()
        let navigationController = UINavigationController()
        let tabBarViewController = MainTabBarViewController()
        navigationController.viewControllers = [tabBarViewController]
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        print("App will resign activity")
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print("App did enter background")
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
}

