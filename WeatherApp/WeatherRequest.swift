//
//  WeatherRequest.swift
//  WeatherApp
//
//  Created by patryk on 04.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation

class WeatherRequest: HttpHandlerRequest {
    
    let apiKey = "38dfeb5e38512ca3433ae28e0391b066"
    
    let celcius = "metric"
    let farenheit = "imperial"
    
    func endPoint() -> String {
        return ""
    }
    
    func headers() -> Dictionary<String, String> {
        return ["Content-Type": "application/json; charset=utf-8"]
    }
    
    func method() -> String {
        return "GET"
    }
    
    func parameters() -> Dictionary<String, Any>? {
        return nil
    }
    
}
