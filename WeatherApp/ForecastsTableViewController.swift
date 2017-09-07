//
//  ViewController.swift
//  WeatherApp
//
//  Created by patryk on 04.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit
import Unbox
import CoreData
import CoreLocation
import AERecord


class ForecastsProvider: ListProviderProtocol {
    var delegate: ListProviderDelegate?
    var weatherManager: WeatherManager

    init() {
        self.weatherManager = WeatherManagerImpl()
    }
    
    func requestData() {
        let locationWarsaw = CLLocationCoordinate2D(latitude: 52.21, longitude: 21.01)
        
        self.weatherManager.fetchWeather(location:locationWarsaw, completion: { [unowned self] (forecasts, error) in
            
            guard let forecasts = forecasts else {
                self.delegate?.didFinishFetchingWithError(nil)
                return
            }
            let data = forecasts.map({ (forecast) -> ForecastData in
                return ForecastData(forecastMo: forecast)
            })
            
            self.delegate?.didFinishFetching(data)
        })
    }
}

class ForecastsTableViewController: UIViewController {
  
    
    @IBOutlet weak var forecastsTableView: UITableView!
    
    var tableViewManager: TableViewManager?
    var dataProvider: ListProviderProtocol?
    
    var forecasts: [ForecastMO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataProvider = ForecastsProvider()
        self.dataProvider?.delegate = self
        self.tableViewManager = TableViewManager(tableView: self.forecastsTableView)
        self.dataProvider?.requestData()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let forecastViewController = segue.destination as? ForecastTableViewController else {
            return
        }
        guard let selectedForecastCell = sender as? ForecastsTableViewCell else {
            return
        }
        guard let indexPath = self.forecastsTableView.indexPath(for: selectedForecastCell) else {
            return
        }
        let selectedForecast = self.forecasts[indexPath.row]
        forecastViewController.forecast = selectedForecast
    }

}

extension ForecastsTableViewController: ListProviderDelegate{
    func didFinishFetching(_ data: [TableViewData]?) {
        self.tableViewManager?.addData(data)
    }
    
    func didStartFetching(_ data: [TableViewData]?) {
        
    }
    
    func didFinishFetchingWithError(_ error: NSError?) {
        
    }
}

extension ForecastsTableViewController: TableViewManagerDelegate{

    func didSelect(_ item: TableViewData) {
        print("selected")
    }
    
    func pinDelegate(_ item: TableViewData) {
        
    }
}
