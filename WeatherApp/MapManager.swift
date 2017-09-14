//
//  MapManager.swift
//  WeatherApp
//
//  Created by patryk on 14.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit
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
    var customMarkerWindow: CustomMarkerWindow?
    
    func initializeMap() {
        let location = CLLocationCoordinate2D(latitude: 52.23, longitude: 21.01)
        let camera = GMSCameraPosition.camera(withLatitude: 52.23, longitude: 21.01, zoom: 7.0)
        self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.mapView?.delegate = self
        self.mapView?.isMyLocationEnabled = true
        self.customMarkerWindow = CustomMarkerWindow.loadView()
        
        // Creates a marker in the center of the map.
        self.currentMarker = GMSMarker()
        self.currentMarker?.position = location
        self.currentMarker?.map = self.mapView
        self.markers.append(self.currentMarker!)
        
        self.delegate?.didInitializeMap(mapView: mapView, marker: currentMarker)
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        if let customMarkerWindow = self.customMarkerWindow, let cond = self.mapView?.subviews.contains(customMarkerWindow), cond  {
            customMarkerWindow.removeFromSuperview()
        } else {
            let marker = GMSMarker()
            marker.position = coordinate
            marker.map = self.mapView
            self.addMarker(marker: marker)
            self.currentMarker = marker
            self.delegate?.didTapAt(location: coordinate)
        }
    }
    
//    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
////        self.delegate?.didTapInfoWindow(marker: marker)
//    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        self.currentMarker = marker
        
        let position = marker.position
        guard let mapView = self.mapView else {
            return false
        }
        mapView.animate(toLocation: position)
        let point = mapView.projection.point(for: position)
        let newPoint = mapView.projection.coordinate(for: point)
        let camera = GMSCameraUpdate.setTarget(newPoint)
        self.mapView?.animate(with: camera)
        
        let opaqueWhite = UIColor(white: 1, alpha: 0.85)
        self.customMarkerWindow?.layer.backgroundColor = opaqueWhite.cgColor
        self.customMarkerWindow?.layer.cornerRadius = 8
        self.customMarkerWindow?.center = mapView.projection.point(for: position)
        if let customMarkerWindow = self.customMarkerWindow {
            self.mapView?.addSubview(customMarkerWindow)
        }
        
        return false
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        return UIView()
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        guard let currentMarker = self.currentMarker else {
            return
        }
        let position = currentMarker.position
        self.customMarkerWindow?.center = mapView.projection.point(for: position)
        self.customMarkerWindow?.center.y -= 140
    }
    
    func removeMarker(marker: GMSMarker) {
        marker.map = nil
        markers = markers.filter() {
            $0 != marker
        }
    }
    
    func addMarker(marker: GMSMarker) {
        self.markers.append(marker)
    }
}
