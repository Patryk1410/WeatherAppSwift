//
//  MapManagerSpec.swift
//  WeatherApp
//
//  Created by patryk on 14.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation
import Quick
import Nimble
import CoreLocation
import GoogleMaps

@testable import WeatherApp

class MapManagerSpec: QuickSpec {
    
    override func spec() {
        
        describe("MapManagerSpec", {
            
            var sut: MapManager!
            var delegate: FakeMapManagerDelegate!
            
            beforeEach {
                GMSServices.provideAPIKey(mapApiKey)
                sut = MapManager()
                delegate = FakeMapManagerDelegate()
                sut.delegate = delegate
            }
            
            describe("Initializing map", {
                
                beforeEach {
                    sut.initializeMap()
                }
                
                it("should have mapView that is not nil", closure: {
                    expect(sut.mapView).toNot(beNil())
                })
                
                it("should have currentMarker that is not nil", closure: {
                    expect(sut.currentMarker).toNot(beNil())
                })
                
                it("should have currentMarker linked to mapView", closure: {
                    expect(sut.currentMarker?.map === sut.mapView).to(beTrue())
                })
                
                it("should have markers array with count of 1", closure: {
                    expect(sut.markers).to(haveCount(1))
                })
                
                it("should have non nil captured mapView", closure: {
                    expect(delegate.capturedMapView).toNot(beNil())
                })
                
                it("should have correct captured mapView", closure: {
                    expect(delegate!.capturedMapView).to(equal(sut.mapView))
                })
                
                it("should have non nil captured marker", closure: {
                    expect(delegate.capturedMarker).toNot(beNil())
                })
                
                it("should have correct captured marker", closure: {
                    expect(delegate.capturedMarker).to(equal(sut.currentMarker))
                })
                
                describe("Tapping at a location while marker window is displayed", {
                    
                    var view: CustomMarkerWindowTemplate!
                    
                    beforeEach {
                        let location = CLLocationCoordinate2D(latitude: 48.85, longitude: 2.35)
                        let marker = GMSMarker(position: location)
                        view = MarkerInfoWindowBuilder.instance.build(marker: marker)
                        sut.mapView!.addSubview(view)
                        sut.mapView(sut.mapView!, didTapAt: location)
                    }
                    
                    it("should dismiss marker window", closure: {
                        expect(sut.mapView?.subviews).toNot(contain(view))
                    })
                })
                
                describe("Tapping at a location while marker window is not displayed", {
                    var location: CLLocationCoordinate2D?
                    
                    beforeEach {
                        location = CLLocationCoordinate2D(latitude: 48.85, longitude: 2.35)
                        sut.mapView(sut.mapView!, didTapAt: location!)
                    }
                    
                    it("should have current marker with new location", closure: {
                        expect(sut.currentMarker?.position.latitude).to(equal(location!.latitude))
                        expect(sut.currentMarker?.position.longitude).to(equal(location!.longitude))
                    })
                    
                    it("should have markers array with count od 2", closure: {
                        expect(sut.markers).to(haveCount(2))
                    })
                    
                    it("should have non nil captured marker", closure: {
                        expect(delegate.capturedMarker).toNot(beNil())
                    })
                    
                    it("should have correct captured location", closure: {
                        expect(delegate.capturedLocation?.latitude).to(equal(sut.currentMarker?.position.latitude))
                        expect(delegate.capturedLocation?.longitude).to(equal(sut.currentMarker?.position.longitude))
                    })
                    
                })
                
                describe("Tapping a marker", {
                    var marker: GMSMarker?
                    var res: Bool?
                    
                    beforeEach {
                        marker = GMSMarker(position: CLLocationCoordinate2D(latitude: 48.85, longitude: 2.35))
                        marker?.map = sut.mapView
                        res = sut.mapView(sut.mapView!, didTap: marker!)
                    }
                    
                    it("current marker should not be nil", closure: {
                        expect(sut.currentMarker).toNot(beNil())
                    })
                    
                    it("current marker should be equal to new marker", closure: {
                        expect(sut.currentMarker).to(equal(marker!))
                    })
                    
                    it("res should not be nil", closure: {
                        expect(res).toNot(beNil())
                    })
                    
                    it("res should be false", closure: {
                        expect(res).to(beFalse())
                    })
                })
                
                describe("Removing a marker", {
                    beforeEach {
                        let marker = sut.currentMarker
                        sut.removeMarker(marker: marker!)
                    }
                    
                    it("should have nil current marker", closure: {
                        expect(sut.currentMarker).to(beNil())
                    })
                    
                    it("should have empty markers array", closure: {
                        expect(sut.markers).to(beEmpty())
                    })
                })
            })
        })
    }
}

