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

class ForecastsTableViewController: UIViewController {
  
    @IBOutlet weak var forecastsTableView: UITableView!
    
    var tableViewManager: TableViewManager?
    var dataProvider: DataProviderProtocol?
    
    var forecasts: [ForecastMO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataProvider = ForecastsProvider()
        self.dataProvider?.delegate = self
        self.tableViewManager = TableViewManager(tableView: self.forecastsTableView)
        self.dataProvider?.requestData()
        self.tableViewManager?.delegate = self
    }
}

extension ForecastsTableViewController: DataProviderDelegate {
    func didFinishFetching(_ data: [DataObjectProtocol]?) {
        self.tableViewManager?.addData(data)
    }
    
    func didStartFetching(_ data: [DataObjectProtocol]?) { }
    
    func didFinishFetchingWithError(_ error: NSError?) { }
}

extension ForecastsTableViewController: TableViewManagerDelegate{

    func didSelect(_ item: DataObjectProtocol) {
        ViewControllerDispatcherImpl.instance.pushForecastTableViewController(navigationController: self.navigationController, forecastData: item as! ForecastData)
    }
    
    func pinDelegate(_ item: DataObjectProtocol) { }
}
