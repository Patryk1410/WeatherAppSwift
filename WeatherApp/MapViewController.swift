//
//  MapViewController.swift
//  WeatherApp
//
//  Created by patryk on 13.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    var marker: GMSMarker!
    var forecastData: ForecastData?
    var dataProvider: MapProvider?
    
    var markerTitle: String = "Warsaw"
    var markerSnippet: String = "Poland"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataProvider = MapProvider()
        dataProvider?.delegate = self
        
        let camera = GMSCameraPosition.camera(withLatitude: 52.23, longitude: 21.01, zoom: 7.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        self.view = mapView
        
        // Creates a marker in the center of the map.
        self.marker = GMSMarker()
        self.marker.position = CLLocationCoordinate2D(latitude: 52.23, longitude: 21.01)
        self.marker.title = "Warsaw, PL"
        self.marker.map = mapView
    }

}

extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        self.marker.position = coordinate
        dataProvider?.location = coordinate
        dataProvider?.requestData()
    }
}

extension MapViewController: ListProviderDelegate {
    
    func didStartFetching(_ data: [TableViewData]?) { }
    
    func didFinishFetching(_ data: [TableViewData]?) {
        guard let data = data?.first as? ForecastData else {
            return
        }
        self.forecastData = data
        self.marker.title = data.city + ", " + data.country
        self.marker.snippet = (data.weatherRecords.first?.temperature.description)! + degreesCelcius
    }
    
    func didFinishFetchingWithError(_ error: NSError?) { }
}
