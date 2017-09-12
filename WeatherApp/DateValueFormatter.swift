//
//  DateValueFormatter.swift
//  WeatherApp
//
//  Created by patryk on 12.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit
import Charts

class DateValueFormatter: NSObject, IAxisValueFormatter {

    let dateFormatter: DateFormatter = DateFormatter()
    
    override init() {
        dateFormatter.dateFormat = "dd-MM hh:mm"
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return self.dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
    
    
}
