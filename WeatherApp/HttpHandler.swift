//
//  HttpHandler.swift
//  WeatherApp
//
//  Created by patryk on 04.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation

protocol HttpHandler {
    
    var baseURL: String { get }
    
    var urlSession: URLSession { get }
    
    func make(request: HttpHandlerRequest, completion: @escaping (_ dictionaryData: [String: Any]?, _ errorError: HttpHandlerError?) -> Void)
}
