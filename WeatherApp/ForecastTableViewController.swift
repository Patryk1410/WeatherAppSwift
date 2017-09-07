//
//  ForecastTableViewController.swift
//  WeatherApp
//
//  Created by patryk on 06.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit

class ForecastProvider: ListProviderProtocol {
    var delegate: ListProviderDelegate?
    
    var forecastData: ForecastData?
    
    func requestData() {
        let weatherRecords = self.forecastData?.weatherRecords
        let data = weatherRecords?.map({ (weatherRecord) in
            return WeatherRecordData(weatherRecord: weatherRecord)
        })
        self.delegate?.didFinishFetching(data)
    }
}

class ForecastTableViewController: UIViewController {

    @IBOutlet weak var forecastTableView: UITableView!
    
    var forecastData: ForecastData?
    var weatherRecords: [WeatherRecordMO]?
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
    
    func setCellLabels(cell: ForecastTableViewCell, weatherRecord: WeatherRecordMO) {
        cell.temperatureLabel.text = Int(weatherRecord.temperature).description + "°C"
        cell.minTemperatureLabel.text = "Min: " + Int(weatherRecord.minTemperature).description + "°C"
        cell.maxTemperatureLabel.text = "Max: " + Int(weatherRecord.maxTemperature).description + "°C"
        cell.dateLabel.text = weatherRecord.date
        cell.conditionsLabel.text = weatherRecord.conditions
        cell.descriptionLabel.text = weatherRecord.conditionsDescription
    }
}

extension ForecastTableViewController: TableViewManagerDelegate {
    func didSelect(_ item: TableViewData) {
        
    }
    
    func pinDelegate(_ item: TableViewData) {
        
    }
}

extension ForecastTableViewController: ListProviderDelegate {
    
    func didFinishFetching(_ data: [TableViewData]?) {
        self.tableViewManager?.addData(data)
    }
    
    func didStartFetching(_ data: [TableViewData]?) {
        
    }
    
    func didFinishFetchingWithError(_ error: NSError?) {
        
    }
}
