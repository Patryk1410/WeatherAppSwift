//
//  WeatherManagerImplSpec.swift
//  WeatherApp
//
//  Created by patryk on 08.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation

import Quick
import Nimble
import CoreLocation
import AERecord
import CoreData

@testable import WeatherApp

class WeatherManagerImplSpec: QuickSpec {
    
    override func spec() {
        
        describe("WeatherManagerImpl") {
            
            var sut: WeatherManagerImpl!
            
            beforeEach {
                sut = WeatherManagerImpl()
                
                let myModel: NSManagedObjectModel = AERecord.modelFromBundle(for: ForecastMO.self)
                let myStoreType = NSInMemoryStoreType
                let myStoreURL = AERecord.storeURL(for: "TestStore")
                let myOptions = [NSMigratePersistentStoresAutomaticallyOption : true]
                do {
                    try AERecord.loadCoreDataStack(managedObjectModel: myModel, storeType: myStoreType, configuration: nil, storeURL: myStoreURL, options: myOptions)
                } catch {
                    print("Error occurred while loading core data stack: \(error)")
                }
            }
            
            afterEach {
                do {
                    let myStoreURL = AERecord.storeURL(for: "TestStore")
                    try AERecord.destroyCoreDataStack(storeURL: myStoreURL)
                } catch {
                    print("Error occurred while destroying core data stack: \(error)")
                }
            }
            
            it("should have http handler correct url", closure: {
                expect(sut.httpHandler?.baseURL).to(equal("http://api.openweathermap.org/data/"))
            })
            
            
            describe("testing performing request", {
                
                let mockedLocation = CLLocationCoordinate2DMake(44, 44)
                let fakeHttpHandler = FakeHttpHandler()
                var capturedResult: [ForecastMO]?
                var capturedError: Error?
                
                beforeEach {
                    
                    sut.httpHandler = fakeHttpHandler
                    
                    sut.fetchWeather(location: mockedLocation, completion: { (result, error) in
                        capturedResult = result
                        capturedError = error
                    })
                    
                }
                
                it("should have correct request class", closure: {
                    expect(fakeHttpHandler.captauredRequest).to(beAKindOf(WeatherByLatitudeAndLongitudeRequest.self))
                })
            
                it("WeatherByLatitudeAndLongitudeRequest has correct latitude ", closure: {
                    let req = fakeHttpHandler.captauredRequest as! WeatherByLatitudeAndLongitudeRequest
                    expect(req.latitude).to(equal(mockedLocation.latitude.description))
                })
                
                it("WeatherByLatitudeAndLongitudeRequest has correct longitude ", closure: {
                    let req = fakeHttpHandler.captauredRequest as! WeatherByLatitudeAndLongitudeRequest
                    expect(req.longitude).to(equal(mockedLocation.longitude.description))
                })
                
                describe("testing unboxing result", {
                    
                    
                    beforeEach {
                        let completion = fakeHttpHandler.capturedCompletionBlock
                        let fakeResponses = FakeResposes()
                        let json: [String: Any?] = fakeResponses.fakeWeatherJson()

                        completion!(json, nil)
                    }
                    
                    it("result should be non empty array", closure: {
                        expect(capturedResult).toNotEventually(beNil())
                    })
                })
                
                
            })
           
            
            
            
           
            
            
        }
    }
}
