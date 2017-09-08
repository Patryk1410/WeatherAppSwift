//
//  HttpHandlerRequest.swift
//  WeatherApp
//
//  Created by patryk on 04.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation

public protocol HttpHandlerRequest {
    
    var apiKey : String { get }
    
    func endPoint() -> String
    
    func method() -> String
    
    func parameters() -> Dictionary<String, Any>?
    
    func headers() -> Dictionary<String, String>

}
