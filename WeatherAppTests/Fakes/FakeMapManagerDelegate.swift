//
//  FakeMapManagerDelegate.swift
//  WeatherApp
//
//  Created by patryk on 14.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation
import GoogleMaps

@testable import WeatherApp

class FakeMapManagerDelegate: NSObject, MapManagerDelegate {
    
    var capturedMapView: GMSMapView?
    var capturedMarker: GMSMarker?
    var capturedLocation: CLLocationCoordinate2D?
    
    func didInitializeMap(mapView: GMSMapView?, marker: GMSMarker?) {
        capturedMapView = mapView
        capturedMarker = marker
    }
    
    func didPressShowDetail(marker: GMSMarker) {
        capturedMarker = marker
    }
    
    func didPressDelete(marker: GMSMarker) {
        capturedMarker = marker
    }
    
    func didTapAt(location: CLLocationCoordinate2D) {
        capturedLocation = location
    }
}
