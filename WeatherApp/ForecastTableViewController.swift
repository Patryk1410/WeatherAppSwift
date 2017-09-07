//
//  ForecastTableViewController.swift
//  WeatherApp
//
//  Created by patryk on 06.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit

class ForecastTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellIdentifier = "ForecastTableViewCell"

    @IBOutlet weak var navigation: UINavigationItem!
    @IBOutlet weak var forecastTableView: UITableView!
    
    var forecast: ForecastMO?
    var weatherRecords: [WeatherRecordMO]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.weatherRecords = self.forecast?.weatherRecords?.array as? [WeatherRecordMO]
        self.forecastTableView.delegate = self
        self.forecastTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setCellLabels(cell: ForecastTableViewCell, weatherRecord: WeatherRecordMO) {
        cell.temperatureLabel.text = Int(weatherRecord.temperature).description + "°C"
        cell.minTemperatureLabel.text = "Min: " + Int(weatherRecord.minTemperature).description + "°C"
        cell.maxTemperatureLabel.text = "Max: " + Int(weatherRecord.maxTemperature).description + "°C"
        cell.dateLabel.text = weatherRecord.date
        cell.conditionsLabel.text = weatherRecord.conditions
        cell.descriptionLabel.text = weatherRecord.conditionsDescription
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (forecast?.weatherRecords?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ForecastTableViewCell
        
        guard let weatherRecords = self.weatherRecords else {
            print("Failed to get weather records while creating cell")
            return cell
        }
        let weatherRecord: WeatherRecordMO = weatherRecords[indexPath.row]
        
        self.setCellLabels(cell: cell, weatherRecord: weatherRecord)
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
