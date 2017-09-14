//
//  MapManager.swift
//  WeatherApp
//
//  Created by patryk on 14.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation
import GoogleMaps

protocol MapManagerDelegate: class {
    
    func didInitializeMap(mapView: GMSMapView?, marker: GMSMarker?)
    
    func didTapInfoWindow(marker: GMSMarker)
    
    func didTapAt(location: CLLocationCoordinate2D)
}

class MapManager: NSObject, GMSMapViewDelegate {
    
    weak var delegate: MapManagerDelegate?
    
    var markers: [GMSMarker] = []
    var currentMarker: GMSMarker?
    var mapView: GMSMapView?
    
    func initializeMap() {
        let location = CLLocationCoordinate2D(latitude: 52.23, longitude: 21.01)
        let camera = GMSCameraPosition.camera(withLatitude: 52.23, longitude: 21.01, zoom: 7.0)
        self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.mapView?.delegate = self
        self.mapView?.isMyLocationEnabled = true
        
        // Creates a marker in the center of the map.
        self.currentMarker = GMSMarker()
        self.currentMarker?.position = location
        self.currentMarker?.map = self.mapView
        self.markers.append(self.currentMarker!)
        
        self.delegate?.didInitializeMap(mapView: mapView, marker: currentMarker)
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker()
        marker.position = coordinate
        marker.map = self.mapView
        self.markers.append(marker)
        self.currentMarker = marker
        self.delegate?.didTapAt(location: coordinate)
        
//        self.currentMarker?.position = coordinate
//        self.delegate?.didTapAt(location: coordinate)
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        
        self.delegate?.didTapInfoWindow(marker: marker)
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        marker.map = nil
        markers = markers.filter() {
            $0 != marker
        }
        return true
    }
    
}
