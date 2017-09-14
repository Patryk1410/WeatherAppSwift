//
//  ForecastTableViewController.swift
//  WeatherApp
//
//  Created by patryk on 06.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit

class ForecastTableViewController: UIViewController {

    @IBOutlet weak var forecastTableView: UITableView!
    
    var forecastData: ForecastData?
    var tableViewManager: TableViewManager?
    var dataProvider: ForecastProvider?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataProvider = ForecastProvider()
        self.dataProvider?.delegate = self
        self.dataProvider?.forecastData = forecastData
        self.tableViewManager = TableViewManager(tableView: self.forecastTableView)
        self.tableViewManager?.delegate = self
        self.dataProvider?.requestData()
    }
    
    func initializeData(data: ForecastData) {
        self.forecastData = data
    }
    
    @IBAction func handleShowChart(_ sender: Any) {
        ViewControllerDispatcherImpl.instance.pushForecastChartViewController(navigationController: self.navigationController, weatherRecords: self.forecastData?.weatherRecords ?? [])
    }
}

extension ForecastTableViewController: TableViewManagerDelegate {
    func didSelect(_ item: DataObjectProtocol) { }
    
    func pinDelegate(_ item: DataObjectProtocol) { }
}

extension ForecastTableViewController: DataProviderDelegate {
    
    func didFinishFetching(_ data: [DataObjectProtocol]?) {
        self.tableViewManager?.addData(data)
    }
    
    func didStartFetching(_ data: [DataObjectProtocol]?) { }
    
    func didFinishFetchingWithError(_ error: NSError?) { }
}
