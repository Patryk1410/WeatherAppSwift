//
//  ForecastChartViewController.swift
//  WeatherApp
//
//  Created by patryk on 11.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit
import Charts

class ForecastChartViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var chartView: WeatherChart!
    var weatherRecords: [WeatherRecordMO]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chartView.setUpChart(self)
        chartView.update(weatherRecords)
    }

}
