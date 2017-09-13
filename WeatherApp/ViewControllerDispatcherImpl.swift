//
//  ViewControllerDispatcher.swift
//  WeatherApp
//
//  Created by patryk on 12.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit

class ViewControllerDispatcherImpl: NSObject, ViewControllerDispatcher {
    
    var lastDestinationViewController: UIViewController!
    
    static let instance: ViewControllerDispatcherImpl = ViewControllerDispatcherImpl()
    
    func pushForecastTableViewController(navigationController: UINavigationController?, forecastData: ForecastData) {
        let destinationViewController = self.getForecastTableViewController()
        destinationViewController.initializeData(data: forecastData)
        navigationController?.pushViewController(destinationViewController, animated: true)
        self.lastDestinationViewController = destinationViewController
    }
    
    func pushForecastChartViewController(navigationController: UINavigationController?, weatherRecords: [WeatherRecordMO]) {
        let destinationViewController = self.getForecastChartViewController()
        destinationViewController.initializeData(data: weatherRecords)
        navigationController?.pushViewController(destinationViewController, animated: true)
        self.lastDestinationViewController = destinationViewController
    }
    
    func getForecastsTableViewController() -> ForecastsTableViewController {
        let storyboard: UIStoryboard = UIStoryboard.init(name: mainStoryboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: forecastsTableViewControllerIdentifier) as! ForecastsTableViewController
    }
    
    func getForecastTableViewController() -> ForecastTableViewController {
        let storyboard: UIStoryboard = UIStoryboard.init(name: mainStoryboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: forecastTableViewControllerIdentifier) as! ForecastTableViewController
    }
    
    func getForecastChartViewController() -> ForecastChartViewController {
        return ForecastChartViewController(nibName: forecastChartViewControllerName, bundle: nil)
    }
    
    func getMapViewController() -> MapViewController {
        return MapViewController(nibName: mapViewControllerName, bundle: nil)
    }
    
    /* Never forgetti
    func pushFromStoryboard(_ parent: UIViewController, data: [String: Any?], destinationViewControllerIdentifier: String) {
        let storyboard: UIStoryboard = UIStoryboard.init(name: mainStoryboardName, bundle: nil)
        self.destinationViewController = storyboard.instantiateViewController(withIdentifier: destinationViewControllerIdentifier) as! BaseViewController
        self.destinationViewController.initializeData(data: data)
        parent.navigationController?.pushViewController(self.destinationViewController, animated: true)
    }
    
    func pushFromXib<T: BaseViewController>(_ parent: BaseViewController, data: [String: Any?], nibName: String, type: T.Type) {
        self.destinationViewController = T(nibName: nibName, bundle: nil)
        self.destinationViewController.initializeData(data: data)
        parent.navigationController?.pushViewController(self.destinationViewController, animated: true)
    }
    */
}
