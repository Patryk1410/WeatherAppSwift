//
//  WeatherChart.swift
//  WeatherApp
//
//  Created by patryk on 12.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit
import Charts

class WeatherChart: LineChartView {
    
    func setUpChart(_ viewController: UIViewController) {
        self.delegate = viewController as? ChartViewDelegate
        self.dragEnabled = true
        self.setScaleEnabled(true)
        self.backgroundColor = UIColor.white
        self.legend.enabled = false
        self.drawGridBackgroundEnabled = false
        self.chartDescription?.enabled = false
        
        let xAxis: XAxis = self.xAxis
        xAxis.labelPosition = XAxis.LabelPosition.bottomInside
        xAxis.labelTextColor = UIColor.purple
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = true;
        xAxis.centerAxisLabelsEnabled = true;
        xAxis.labelFont = UIFont.systemFont(ofSize: 8.0)
        xAxis.valueFormatter = DateValueFormatter()
        
        let leftAxis = self.leftAxis;
        leftAxis.labelPosition = YAxis.LabelPosition.insideChart;
        leftAxis.labelTextColor = UIColor.magenta
        leftAxis.drawGridLinesEnabled = true;
        leftAxis.granularityEnabled = true;
        leftAxis.valueFormatter = TemperatureValueFormatter()
        
        self.rightAxis.enabled = false
        self.animate(xAxisDuration: 1.35)
    }
    
    func update(_ weatherRecords: [WeatherRecordMO]?) {
        guard let weatherRecords = weatherRecords else {
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
        self.data = data
    }
}
