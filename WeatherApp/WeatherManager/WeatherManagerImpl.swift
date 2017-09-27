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
import PromiseKit

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

    private func performRequest(location: CLLocationCoordinate2D) -> Promise<(HttpHandlerRequest, HttpHandler)> {
        return Promise { fullfil, reject in
            let request = WeatherByLatitudeAndLongitudeRequest(latitude: location.latitude.description, longitude: location.longitude.description)
            guard let handler = self.httpHandler else {
                reject(WeatherManagerError.somethingWentWrong)
                return
            }
            fullfil((request, handler))
        }
    }
    
    func fetchWeather(location: CLLocationCoordinate2D, context: NSManagedObjectContext) -> Promise<[ForecastMO]> {
        return Promise { fulfill, reject in
            firstly {
                self.performRequest(location: location)
            }.then { (request, handler) in
                handler.make(request: request)
            }.then { result in
                self.performUnboxingOperation(result: result, context: context, shouldUpdateForecast: true, shouldSaveForecast: true)
            }.then { _ in
                DispatchQueue.main.async {
                    let forecasts = ForecastMO.all()
                    fulfill(forecasts as? [ForecastMO] ?? [])
                }
            }.catch {_ in
                // handle errors
            }
        }
    }
    
    func fetchOneForecast(location: CLLocationCoordinate2D, context: NSManagedObjectContext, shouldUpdateForecast: Bool) -> Promise<ForecastMO> {
        return Promise { fulfill, reject in
            firstly {
                self.performRequest(location: location)
            }.then { (request, handler) in
                handler.make(request: request)
            }.then { result in
                self.performUnboxingOperation(result: result, context: context, shouldUpdateForecast: shouldUpdateForecast, shouldSaveForecast: false)
            }.then { forecast in
                fulfill(forecast)
            }.catch { _ in
                // handle errors
            }
        }
    }
    
    func performUnboxingOperation(result: [String: Any], context: NSManagedObjectContext, shouldUpdateForecast: Bool, shouldSaveForecast: Bool) -> Promise<ForecastMO> {
        return Promise { fulfill, reject in
            let unboxingOperation = ForecastUnboxingOperation(result: result, context: context, shouldUpdateForecast: shouldUpdateForecast, shouldSaveForecast: shouldSaveForecast)
            let operationManager = OperationManager()
            unboxingOperation.completionBlock = {
                if unboxingOperation.isCancelled {
                    reject(WeatherManagerError.unboxingFailed)
                }
                guard let forecast = unboxingOperation.forecast else {
                    reject(WeatherManagerError.unboxingFailed)
                    return
                }
                fulfill(forecast)
            }
            operationManager.downloadQueue.addOperation(unboxingOperation)
        }
    }
}
