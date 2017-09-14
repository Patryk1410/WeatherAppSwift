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
        
        self.viewControllers = [forecastTab, mapTab]
    }
}

extension MainTabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) { }
}
