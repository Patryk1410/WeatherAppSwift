//
//  ViewControllerDispatcherImplSpec.swift
//  WeatherApp
//
//  Created by patryk on 13.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation
import Nimble
import Quick
import AERecord
import CoreData

@testable import WeatherApp

class ViewControllerDispatcherImplSpec: QuickSpec {
    
    override func spec() {
        
        describe("ViewControllerDispatcherImplSpec", {
            
            var sut: ViewControllerDispatcherImpl!
            var context: NSManagedObjectContext?
            var fakeNavigationController: FakeNavigationController?
            
            var capturedViewController: UIViewController?
            var capturedAnimated: Bool?
            
            beforeEach {
                let myModel: NSManagedObjectModel = AERecord.modelFromBundle(for: ForecastMO.self)
                let myStoreType = NSInMemoryStoreType
                let myStoreURL = AERecord.storeURL(for: "TestStore")
                let myOptions = [NSMigratePersistentStoresAutomaticallyOption : true]
                do {
                    try AERecord.loadCoreDataStack(managedObjectModel: myModel, storeType: myStoreType, configuration: nil, storeURL: myStoreURL, options: myOptions)
                    context = AERecord.Context.default
                } catch {
                    print("Error occurred while loading core data stack: \(error)")
                    return
                }
                
                sut = ViewControllerDispatcherImpl()
                fakeNavigationController = FakeNavigationController()
            }
            
            afterEach {
                do {
                    let myStoreURL = AERecord.storeURL(for: "TestStore")
                    try AERecord.destroyCoreDataStack(storeURL: myStoreURL)
                } catch {
                    print("Error occurred while destroying core data stack: \(error)")
                }
            }
            
            describe("pushing ForecastTableViewController", {
                
                var forecastData: ForecastData?
                
                beforeEach {
                    let fakeResponses: FakeResposes = FakeResposes()
                    let json: [String: Any?] = fakeResponses.fakeWeatherJson()
                    let unboxer: ForecastUnboxer = ForecastUnboxer()
                    do {
                        let forecast: ForecastMO = try unboxer.unbox(dictionary: json, managedContext: context!)
                        forecastData = ForecastData(forecast: forecast)
                        sut.pushForecastTableViewController(navigationController: fakeNavigationController, forecastData: forecastData!)
                    } catch {
                        print("Error occurred while unboxing: \(error)")
                    }
                }
                
                it("Should have destinationViewController that is not nil", closure: {
                    expect(sut.lastDestinationViewController).toNot(beNil())
                })
                
                it("Should have destinationViewController of type ForecastTableViewController", closure: {
                    expect(sut.lastDestinationViewController).to(beAKindOf(ForecastTableViewController.self))
                })
                
                it("Should have destinationViewController that has non-nil data", closure: {
                    expect((sut.lastDestinationViewController as! ForecastTableViewController).forecastData).toNot(beNil())
                })
                
                it("Should have destinationViewController that has correct data", closure: {
                    expect((sut.lastDestinationViewController as! ForecastTableViewController).forecastData).to(equal(forecastData))
                })
                
                it("Should have invoked push method and have capturedViewController", closure: {
                    expect(fakeNavigationController?.capturedViewController).to(equal(sut.lastDestinationViewController))
                })
                
                it("Should have invoked push method and have capturedAnimated", closure: {
                    expect(fakeNavigationController?.capturedAnimated).to(beTrue())
                })
            })
            
            describe("pushing ForecastChartViewController", {
                
                var weatherRecords: [WeatherRecordMO]?
                
                beforeEach {
                    let fakeResponses: FakeResposes = FakeResposes()
                    let json: [String: Any?] = fakeResponses.fakeWeatherJson()
                    let unboxer: ForecastUnboxer = ForecastUnboxer()
                    do {
                        let forecast: ForecastMO = try unboxer.unbox(dictionary: json, managedContext: context!)
                        let forecastData: ForecastData = ForecastData(forecast: forecast)
                        weatherRecords = forecastData.weatherRecords
                        sut.pushForecastChartViewController(navigationController: fakeNavigationController, weatherRecords: weatherRecords!)
                    } catch {
                        print("Error occurred while unboxing: \(error)")
                    }
                }
                
                it("Should have destinationViewController that is not nil", closure: {
                    expect(sut.lastDestinationViewController).toNot(beNil())
                })
                
                it("Should have destinationViewController of type ForecastChartViewController", closure: {
                    expect(sut.lastDestinationViewController).to(beAKindOf(ForecastChartViewController.self))
                })
                
                it("Should have destinationViewController that has non-nil data", closure: {
                    expect((sut.lastDestinationViewController as! ForecastChartViewController).weatherRecords).toNot(beNil())
                })
                
                it("Should have destinationViewController that is not empty", closure: {
                    expect((sut.lastDestinationViewController as! ForecastChartViewController).weatherRecords).toNot(beEmpty())
                })
                
                it("Should have destinationViewController that has correct data", closure: {
                    expect((sut.lastDestinationViewController as! ForecastChartViewController).weatherRecords).to(equal(weatherRecords))
                })
                
                it("Should have invoked push method", closure: {
                    expect(fakeNavigationController?.capturedViewController).to(equal(sut.lastDestinationViewController))
                })
                
                it("Should have invoked push method and have capturedAnimated", closure: {
                    expect(fakeNavigationController?.capturedAnimated).to(beTrue())
                })
            })
        })
    }
}
