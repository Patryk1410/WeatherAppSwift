//
//  TemperatureValueFormatter.swift
//  WeatherApp
//
//  Created by patryk on 12.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit
import Charts

class TemperatureValueFormatter: NSObject, IAxisValueFormatter {

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return String(value) + degreesCelcius
    }
}
