//
//  WeatherManagerImpl.swift
//  WeatherApp
//
//  Created by patryk on 06.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation
import CoreLocation
import CoreData
import AERecord

enum WeatherManagerError: Error {
    case noData
    case unboxingFailed
    case somethingWentWrong
}

class WeatherManagerImpl: WeatherManager {
    
    var httpHandler: HttpHandler?
    let forecastUnboxer: ForecastUnboxer

    init() {
        self.httpHandler = HttpClient(baseURL: baseURL)
        self.forecastUnboxer = ForecastUnboxer()
    }

    private func performRequest(location: CLLocationCoordinate2D, completion: (HttpHandlerRequest?, HttpHandler?, Error?) -> ()) {
        let request = WeatherByLatitudeAndLongitudeRequest(latitude: location.latitude.description, longitude: location.longitude.description)
        
        guard let handler = self.httpHandler else {
            completion(nil, nil, WeatherManagerError.somethingWentWrong)
            return
        }
        
        completion(request, handler, nil)
    }
    
    func fetchWeather(location: CLLocationCoordinate2D, context: NSManagedObjectContext, completion: @escaping ([ForecastMO]?, Error?) -> ()) {
        performRequest(location: location, completion: { (request, handler, error) in
            guard let handler = handler, let request = request else {
                completion(nil, error)
                return
            }
            handler.make(request: request, completion: { (result, error) in
                guard let result = result else {
                    completion(nil, WeatherManagerError.noData)
                    return
                }
                self.performUnboxingOperation(result: result, context: context, shouldUpdateForecast: true, shouldSaveForecast: true, completion: { (forecast) in
                    let forecasts = ForecastMO.all()
                    completion(forecasts as? [ForecastMO], nil)
                })
            })
        })
    }
    
    func fetchOneForecast(location: CLLocationCoordinate2D, context: NSManagedObjectContext, shouldUpdateForecast: Bool, completion:@escaping (ForecastMO?, Error?) -> ()) {
        performRequest(location: location, completion: { (request, handler, error) in
            guard let handler = handler, let request = request else {
                completion(nil, error)
                return
            }
            handler.make(request: request, completion: { (result, error) in
                guard let result = result else {
                    completion(nil, WeatherManagerError.noData)
                    return
                }
                self.performUnboxingOperation(result: result, context: context, shouldUpdateForecast: shouldUpdateForecast, shouldSaveForecast: false, completion: { (forecast) in
                    completion(forecast, nil)
                })
            })
        })
    }
    
    func performUnboxingOperation(result: [String: Any?], context: NSManagedObjectContext, shouldUpdateForecast: Bool, shouldSaveForecast: Bool, completion: @escaping (ForecastMO)->()) {
        let unboxingOperation = ForecastUnboxingOperation(result: result, context: context, shouldUpdateForecast: shouldUpdateForecast, shouldSaveForecast: shouldSaveForecast)
        let operationManager = OperationManager()
        unboxingOperation.completionBlock = {
            if unboxingOperation.isCancelled {
                return
            }
            guard let forecast = unboxingOperation.forecast else {
                return
            }
            DispatchQueue.main.async {
                completion(forecast)
            }
        }
        operationManager.downloadQueue.addOperation(unboxingOperation)
    }
}
