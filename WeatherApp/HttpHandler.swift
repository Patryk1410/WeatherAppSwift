//
//  HttpHandler.swift
//  WeatherApp
//
//  Created by patryk on 04.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation
import PromiseKit

public protocol HttpHandler {
    
    var baseURL: String { get }
    
    var urlSession: URLSession { get }
    
    func make(request: HttpHandlerRequest) -> Promise<[String: Any]>
}
