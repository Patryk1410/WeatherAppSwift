//
//  CustomMarkerWindowProtocol.swift
//  WeatherApp
//
//  Created by patryk on 18.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation
import GoogleMaps

class CustomMarkerWindowTemplate: UIView {
    
    weak var mapDelegate: MapManagerDelegate?
    
    func loadData(marker: GMSMarker) {
        fatalError("Error: invoked function loadData from abstract class CustomMarkerWindowTemplate")
    }
}
