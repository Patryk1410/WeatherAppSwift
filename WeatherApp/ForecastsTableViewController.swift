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
    var dataProvider: ListProviderProtocol?
    
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

extension ForecastsTableViewController: ListProviderDelegate {
    func didFinishFetching(_ data: [TableViewData]?) {
        self.tableViewManager?.addData(data)
    }
    
    func didStartFetching(_ data: [TableViewData]?) { }
    
    func didFinishFetchingWithError(_ error: NSError?) { }
}

extension ForecastsTableViewController: TableViewManagerDelegate{

    func didSelect(_ item: TableViewData) {
        ViewControllerDispatcherImpl.instance.pushForecastTableViewController(navigationController: self.navigationController, forecastData: item as! ForecastData)
    }
    
    func pinDelegate(_ item: TableViewData) { }
}
