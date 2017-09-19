//
//  MarkerInfoWindowBuilderSpec.swift
//  WeatherApp
//
//  Created by patryk on 18.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation
import Quick
import Nimble
import CoreLocation
import GoogleMaps

@testable import WeatherApp

class MarkerInfoWindowBuilderSpec: QuickSpec {
    
    override func spec() {
        
        describe("MarkerInfoWindowBuilderSpec", {
            var sut: MarkerInfoWindowBuilder!
            var window: CustomMarkerWindowTemplate!
            
            beforeEach {
                sut = MarkerInfoWindowBuilder.instance
            }
            
            describe("Building window for lodz location", {
                
                beforeEach {
                    let location = CLLocationCoordinate2D(latitude: 51.759, longitude: 19.456)
                    let marker = GMSMarker(position: location)
                    window = sut.build(marker: marker)
                }
                
                it("should not be nil", closure: {
                    expect(window).toNot(beNil())
                })
                
                it("should be of type LodzCustomMarkerWindow", closure: {
                    expect(window).to(beAKindOf(LodzCustomMarkerWindow.self))
                })
            })
            
            describe("Building window for other location", {
                
                beforeEach {
                    let location = CLLocationCoordinate2D(latitude: 25.3, longitude: 2.342)
                    let marker = GMSMarker(position: location)
                    window = sut.build(marker: marker)
                }
                
                it("should not be nil", closure: {
                    expect(window).toNot(beNil())
                })
                
                it("should be of type CustomMarkerWindow", closure: {
                    expect(window).to(beAKindOf(CustomMarkerWindow.self))
                })
            })
        })
    }
}
