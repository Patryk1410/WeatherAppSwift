//
//  MainTabBarViewController.swift
//  WeatherApp
//
//  Created by patryk on 13.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        
        let forecastTab = ViewControllerDispatcherImpl.instance.getForecastsTableViewController()
        let forecastItem = UITabBarItem(title: forecastsTabTitle, image: nil, selectedImage: nil)
        forecastTab.tabBarItem = forecastItem
        
        let mapTab = ViewControllerDispatcherImpl.instance.getMapViewController()
        let mapItem = UITabBarItem(title: mapTabTitle, image: nil, selectedImage: nil)
        mapTab.tabBarItem = mapItem
        
        let beaconTab = ViewControllerDispatcherImpl.instance.getBeaconViewController()
        let beaconItem = UITabBarItem(title: beaconTabTitle, image: nil, selectedImage: nil)
        beaconTab.tabBarItem = beaconItem
        
        self.viewControllers = [forecastTab, mapTab, beaconTab]
    }
}

extension MainTabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) { }
}
