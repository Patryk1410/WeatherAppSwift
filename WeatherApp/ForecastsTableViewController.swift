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

class ForecastsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let numberOfSections = 1
    let cellIdentifier = "ForecastsTableViewCell"
    
    @IBOutlet weak var forecastsTableView: UITableView!
    
    var weatherManager: WeatherManager?
    
    var forecasts: [ForecastMO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.forecastsTableView.dataSource = self
        self.forecastsTableView.delegate = self
//        self.forecastsTableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
      
        self.weatherManager = WeatherManagerImpl()
        let location = CLLocationCoordinate2D(latitude: 52.21, longitude: 21.01)
        
        self.weatherManager?.fetchWeather(location:location, completion: { (forecasts, error) in
            guard let forecasts = forecasts else {
                return
            }
            self.forecasts = forecasts
            self.forecastsTableView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ForecastsTableViewCell
        let forecast = forecasts[indexPath.row]
        self.setCellLabels(cell: cell, forecast: forecast)
        
        
        return cell
    }
    
    func setCellLabels(cell: ForecastsTableViewCell, forecast: ForecastMO) {
        cell.locationLabel.text = (forecast.location?.city)! + ", " +
         (forecast.location?.country)!
        cell.dateLabel.text = (forecast.weatherRecords?.firstObject as! WeatherRecordMO).date! + " - " + (forecast.weatherRecords?.lastObject as! WeatherRecordMO).date!
    }

}

