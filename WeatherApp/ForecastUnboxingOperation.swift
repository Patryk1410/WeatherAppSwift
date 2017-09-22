//
//  WeatherDownloader.swift
//  WeatherApp
//
//  Created by patryk on 21.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation
import CoreData


class ForecastUnboxingOperation: Operation {
    
    let unboxer: ForecastUnboxer
    let context: NSManagedObjectContext
    let shouldUpdateForecast: Bool
    let shouldSaveForecast: Bool
    let result: [String: Any?]
    var forecast: ForecastMO?
    
    init(result: [String: Any?], context: NSManagedObjectContext, shouldUpdateForecast: Bool, shouldSaveForecast: Bool) {
        self.result = result
        self.unboxer = ForecastUnboxer()
        self.context = context
        self.shouldUpdateForecast = shouldUpdateForecast
        self.shouldSaveForecast = shouldSaveForecast
    }
    
    override func main() {
        if self.isCancelled {
            return
        }
        do {
        self.forecast = try self.unboxer.unbox(dictionary: self.result, shouldSaveForecast: self.shouldSaveForecast, shouldUpdateForecast: self.shouldUpdateForecast, context: self.context)
        } catch {
            print("Unboxing error")
        }
    }
}
