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

    @IBOutlet weak var chartView: LineChartView!
    var weatherRecords: [WeatherRecordMO]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.chartView.delegate = self
        self.chartView.dragEnabled = true
        self.chartView.setScaleEnabled(true)
        self.chartView.backgroundColor = UIColor.white
        self.chartView.legend.enabled = false
        self.chartView.drawGridBackgroundEnabled = false
        self.chartView.chartDescription?.enabled = false
        
        let xAxis: XAxis = self.chartView.xAxis
        xAxis.labelPosition = XAxis.LabelPosition.bottomInside
        xAxis.labelTextColor = UIColor.purple
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = true;
        xAxis.centerAxisLabelsEnabled = true;
        xAxis.labelFont = UIFont.systemFont(ofSize: 8.0)
        xAxis.valueFormatter = DateValueFormatter()
        
        let leftAxis = self.chartView.leftAxis;
        leftAxis.labelPosition = YAxis.LabelPosition.insideChart;
        leftAxis.labelTextColor = UIColor.magenta
        leftAxis.drawGridLinesEnabled = true;
        leftAxis.granularityEnabled = true;
//        leftAxis.yOffset = -9.0;
        leftAxis.valueFormatter = TemperatureValueFormatter()
        
        self.chartView.rightAxis.enabled = false
        self.chartView.animate(xAxisDuration: 1.35)
        
        updateChart()
    }
    
    func updateChart() {
        guard let weatherRecords = self.weatherRecords else {
            return
        }
        var entries: [ChartDataEntry] = []
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        for record in weatherRecords {
            let date: Date = dateFormatter.date(from: record.date ?? "")!
            let time: Double = date.timeIntervalSince1970
            let value: Double = record.temperature
            let entry: ChartDataEntry = ChartDataEntry(x: time, y: value)
            entries.append(entry)
        }
        
        let dataSet: LineChartDataSet = LineChartDataSet(values: entries, label: "Temperature")
        dataSet.valueTextColor = UIColor.darkGray
        dataSet.lineWidth = 2.0
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.fillColor = UIColor.darkGray
        
        let data: LineChartData = LineChartData(dataSets: [dataSet])
       
        //setter sends notification to update data
        self.chartView.data = data
        
//        self.chartView.notifyDataSetChanged()
    }

}
