//
//  WeatherHandler.swift
//  WeatherApp
//
//  Created by patryk on 04.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation

class WeatherHandler {
    
    var urlSession: URLSession = URLSession(configuration: URLSessionConfiguration.default)
    
    func make(request: HttpHandlerRequest, completion: @escaping ([String : Any]?, HttpHandlerError?) -> Void) {
//        if let url = URL(string: baseUrl.appending("id=").appending(cityId).appending("&APPID").appending(apiKey)) {
////            (urlSession.dataTask(with: url, completionHandler: completion))
//        }
    }
    
    func make() {
        if let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?id=524901&APPID=38dfeb5e38512ca3433ae28e0391b066") {
            (urlSession.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("error \(error)")
                } else if let response = response,
                    let data = data,
                    let string = String(data: data, encoding: .utf8) {
                        print("response \(response)")
                        print("data \(string)")
                        let dict = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    print(dict ?? "error")
                }
            }).resume()
        }
    }
}
