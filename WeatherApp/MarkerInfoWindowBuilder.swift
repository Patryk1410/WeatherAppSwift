//
//  MarkerInfoWindowBuilder.swift
//  WeatherApp
//
//  Created by patryk on 18.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation
import GoogleMaps

class MarkerInfoWindowBuilder: NSObject {
    
    static let instance = MarkerInfoWindowBuilder()
    
    private var window: CustomMarkerWindowTemplate?
    private let lodzLocation: CLLocation?
    
    override init() {
        self.lodzLocation = CLLocation(latitude: 51.759, longitude: 19.456)
    }
    
    func build(marker: GMSMarker) -> CustomMarkerWindowTemplate? {
        var window: CustomMarkerWindowTemplate?
        
        var xibName: String
        let markerLocation = CLLocation(latitude: marker.position.latitude, longitude: marker.position.longitude)
        if markerLocation.distance(from: self.lodzLocation!) <= 25000.0 {
            xibName = lodzCustomMarkerWindowName
        } else {
            xibName = customMarkerWindowName
        }
        window = loadView(name: xibName)
        window?.loadData(marker: marker)
        return window
    }
    
    func loadView(name: String) -> CustomMarkerWindowTemplate? {
        let customInfoWindow = Bundle.main.loadNibNamed(name, owner: self, options: nil)?[0] as? CustomMarkerWindowTemplate ?? nil
        customInfoWindow?.layer.cornerRadius = 8
        return customInfoWindow
    }
}
