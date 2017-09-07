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

    let baseURL = "http://api.openweathermap.org/data/"

    let lodzLocationId: String = "3093133"

    let httpHandler: HttpHandler?
    let forecastUnboxer: ForecastUnboxer

    init() {
        self.httpHandler = HttpClient(baseURL: baseURL)
        self.forecastUnboxer = ForecastUnboxer()
    }

    func fetchWeather(location: CLLocationCoordinate2D, completion: @escaping ([ForecastMO]?, Error?) -> ()) {
        let request = WeatherByLatitudeAndLongitudeRequest(latitude: location.latitude.description, longitude: location.longitude.description)

        guard let handler = self.httpHandler else {
            completion(nil, WeatherManagerError.somethingWentWrong)
            return
        }

        handler.make(request: request, completion: { (result, error) in
            guard let result = result else {
                completion(nil, WeatherManagerError.noData)
                return
            }
            do {
                let ctx = AERecord.Context.default
                ctx.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                
                let from = ((result["list"] as? [Any?])?.first as? [String: Any?])?["dt_txt"] as? String
                let pred = NSPredicate(format: "from == %@", from ?? "")
                
                if (ForecastMO.count(with: pred)) > 0 {
                    ForecastMO.deleteAll(with: pred)
                }
                
//                var forecastsInDb = ForecastMO.all(with: pred)
                let forecast = try self.forecastUnboxer.unbox(dictionary: result, managedContext: ctx)
//                forecastsInDb = ForecastMO.all(with: pred)
                
//                let fetchRequest = NSFetchRequest<ForecastMO>(entityName: "ForecastMO")
//                fetchRequest.predicate = NSPredicate(format: "from == %@", forecast.from!)
//                let fetchedForecast = try ctx.execute(fetchRequest)
                
                
//                if ForecastMO.first(with: pred) != nil {
//                    ForecastMO.deleteAll(with: pred)
//                }
                
                AERecord.saveAndWait(context: ctx)
                DispatchQueue.main.async {
        
                    let forecasts = ForecastMO.all()
                    completion(forecasts as? [ForecastMO], nil)
                }

            } catch {
                print("Error occurred while unboxing: \(error)")
            }
        })
    }
}
