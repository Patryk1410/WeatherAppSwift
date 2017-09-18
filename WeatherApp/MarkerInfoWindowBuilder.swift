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
    
    func build(marker: GMSMarker) -> CustomMarkerWindowTemplate? {
        var window: CustomMarkerWindowTemplate?
        
        window = loadView(name: customMarkerWindowName)
        window?.loadData(marker: marker)
        
        
        return window
    }
    
    func loadView(name: String) -> CustomMarkerWindowTemplate? {
        
        let customInfoWindow = Bundle.main.loadNibNamed(name, owner: self, options: nil)?[0] as? CustomMarkerWindowTemplate ?? nil
        let opaqueWhite = UIColor(white: 1, alpha: 0.85)
        customInfoWindow?.layer.backgroundColor = opaqueWhite.cgColor
        customInfoWindow?.layer.cornerRadius = 8
        return customInfoWindow
    }
}
