//
//  FakeHttpHandler.swift
//  WeatherApp
//
//  Created by patryk on 08.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation
import WeatherApp

class FakeHttpHandler: HttpHandler {
    
    var baseURL: String = ""
    
    var urlSession: URLSession
    
    init() {
        urlSession = URLSession(configuration: .default)
    }
    var captauredRequest: HttpHandlerRequest?
    var capturedCompletionBlock: (([String : Any]?, HttpHandlerError?) -> Void)?
    
    func make(request: HttpHandlerRequest, completion: @escaping ([String : Any]?, HttpHandlerError?) -> Void) {
        self.captauredRequest = request
        self.capturedCompletionBlock = completion
    }
}
