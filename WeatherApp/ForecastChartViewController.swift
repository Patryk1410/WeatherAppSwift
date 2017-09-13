//
//  ForecastChartViewController.swift
//  WeatherApp
//
//  Created by patryk on 11.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit
import Charts

class ForecastChartViewController: BaseViewController {

    @IBOutlet weak var chartView: WeatherChart!
    var weatherRecords: [WeatherRecordMO]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chartView.setUpChart(self)
        chartView.update(weatherRecords)
    }
    
    override func initializeData(data: [String : Any?]) {
        self.weatherRecords = data[weatherRecordsDataKey] as? [WeatherRecordMO]
    }
}

extension ForecastChartViewController: ChartViewDelegate {
    
}
