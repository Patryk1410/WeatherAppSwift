//
//  ViewControllerDispatcher.swift
//  WeatherApp
//
//  Created by patryk on 12.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit

protocol ViewControllerDispatcher {
    
    func pushForecastTableViewController(navigationController: UINavigationController?, forecastData: ForecastData)
    
    func pushForecastChartViewController(navigationController: UINavigationController?, weatherRecords: [WeatherRecordMO])
    
    func getForecastsTableViewController() -> ForecastsTableViewController
    
    func getForecastTableViewController() -> ForecastTableViewController
    
    func getForecastChartViewController() -> ForecastChartViewController
    
    func getMapViewController() -> MapViewController
    
    /*RIP [*]
    func pushFromStoryboard(_ parent: UIViewController, data: [String: Any?], destinationViewControllerIdentifier: String)
    
    func pushFromXib<T: BaseViewController>(_ parent: BaseViewController, data: [String: Any?], nibName: String, type: T.Type)
    */
}
