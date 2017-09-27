//
//  HttpClient.swift
//  WeatherApp
//
//  Created by patryk on 04.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation
import PromiseKit

class HttpClient: HttpHandler {
    
    var baseURL: String
    var urlSession: URLSession
    
    init(baseURL: String) {
        self.baseURL = baseURL
        self.urlSession = URLSession(configuration: .default)
    }
    
    func make(request: HttpHandlerRequest) -> Promise<[String: Any]> {
        return Promise { fulfill, reject in
            let endpoint = request.endPoint()
            let method = request.method()
            guard let url = URL(string: self.baseURL + endpoint) else {
                reject(HttpHandlerError.WrongUrl)
                return
            }
            var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60)
            urlRequest.httpMethod = method
            let headers = request.headers()
            
            for (key, value) in headers {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
            
            if let params = request.parameters(), request.method() != httpGet {
                do {
                    let paramsData = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions(rawValue: 0))
                    urlRequest.httpBody = paramsData
                } catch {
                    print("HttpHandler error " + error.localizedDescription)
                }
            }
            
            (self.urlSession.dataTask(with: url) { (data, response, error) in
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    reject(HttpHandlerError.NoDataFromServer)
                    return
                }
                
                guard httpResponse.statusCode == 200 else {
                    reject(HttpHandlerError.WrongStatusCode)
                    return
                }
                
                guard let data = data else {
                    reject(HttpHandlerError.NoDataFromServer)
                    return
                }
                
                guard let dict: [String: Any] = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] else {
                    reject(HttpHandlerError.ServerResponseNotParseable)
                    return
                }
                
                fulfill(dict)
                
            }).resume()
        }
    }
}
