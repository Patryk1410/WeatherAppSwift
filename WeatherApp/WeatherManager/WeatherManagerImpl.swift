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
                do {
                    _ = try self.forecastUnboxer.unbox(dictionary: result, shouldSaveForecast: true, shouldUpdateForecast: true, context: context)
                    DispatchQueue.main.async {
                        let forecasts = ForecastMO.all()
                        completion(forecasts as? [ForecastMO], nil)
                    }
                    
                } catch {
                    print("Error occurred while unboxing: \(error)")
                    completion(nil, WeatherManagerError.unboxingFailed)
                }
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
                do {
                    let forecast = try self.forecastUnboxer.unbox(dictionary: result, shouldSaveForecast: false, shouldUpdateForecast: shouldUpdateForecast, context: context)
                    completion(forecast, nil)
                } catch {
                    print("Error occurred while unboxing: \(error)")
                    completion(nil, WeatherManagerError.unboxingFailed)
                }
            })
        })
        
        
    }
}
