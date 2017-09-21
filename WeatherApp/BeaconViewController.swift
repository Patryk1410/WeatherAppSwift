//
//  BeaconViewController.swift
//  WeatherApp
//
//  Created by patryk on 18.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit

class BeaconViewController: UIViewController {

    @IBOutlet weak var beaconRecordsTableView: UITableView!
    
    var tableViewManager: TableViewManager?
    var dataProvider: DataProviderProtocol?
    
    var beaconRecords: [BeaconRecordMO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataProvider = BeaconRecordsProvider()
        self.dataProvider?.delegate = self
        self.tableViewManager = TableViewManager(tableView: self.beaconRecordsTableView)
        self.tableViewManager?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableViewManager?.removeAllData()
        self.dataProvider?.requestData()
    }

}

extension BeaconViewController: TableViewManagerDelegate{
    
    func didSelect(_ item: DataObjectProtocol) {
        guard let beaconRecordData = item as? BeaconRecordData else {
            return
        }
        let forecastData = ForecastData(forecast: beaconRecordData.forecast)
        ViewControllerDispatcherImpl.instance.pushForecastTableViewController(navigationController: self.navigationController, forecastData: forecastData)
    }
    
    func pinDelegate(_ item: DataObjectProtocol) { }
}

extension BeaconViewController: DataProviderDelegate {
    func didFinishFetching(_ data: [DataObjectProtocol]?) {
        self.tableViewManager?.addData(data)
    }
    
    func didStartFetching(_ data: [DataObjectProtocol]?) { }
    
    func didFinishFetchingWithError(_ error: NSError?) { }
    
}
