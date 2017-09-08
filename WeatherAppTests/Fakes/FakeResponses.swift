//
//  FakeResponses.swift
//  WeatherApp
//
//  Created by patryk on 08.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation

class FakeResposes {
    
    func fakeWeatherJson() -> [String: Any?] {
        let bundle = Bundle(for: FakeHttpHandler.self)
       
        guard let file = bundle.url(forResource: "FakeWeatherResponse", withExtension: "json") else {
            return [:]
        }
        do {
            let data = try Data(contentsOf: file)
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any?] else {
                return [:]
            }
            return dictionary
        } catch {
            print("Error occurred while parsing json file \(error)")
            return [:]
        }
    }
}
