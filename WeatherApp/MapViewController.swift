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

    var forecastData: ForecastData?
    var mapManager: MapManager?
    var dataProvider: MapProvider?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataProvider = MapProvider()
        self.dataProvider?.delegate = self
        self.mapManager = MapManager()
        self.mapManager?.delegate = self
        
        let location = CLLocationCoordinate2D(latitude: 52.23, longitude: 21.01)
        self.dataProvider?.location = location
        
        self.mapManager?.initializeMap()
    }

}

extension MapViewController: MapManagerDelegate {
    
    func didTapAt(location: CLLocationCoordinate2D) {
        dataProvider?.location = location
        dataProvider?.requestData()
    }
    
    func didTapInfoWindow(marker: GMSMarker) {
        guard let data = marker.userData as? ForecastData else {
            return
        }
        ViewControllerDispatcherImpl.instance.pushForecastTableViewController(navigationController: self.navigationController, forecastData: data)
    }
    
    func didInitializeMap(mapView: GMSMapView?, marker: GMSMarker?) {
        self.view = mapView
        self.dataProvider?.requestData()
    }
}

extension MapViewController: DataProviderDelegate {
    
    func didStartFetching(_ data: [DataObjectProtocol]?) { }
    
    func didFinishFetching(_ data: [DataObjectProtocol]?) {
        guard let data = data?.first as? ForecastData else {
            return
        }
        self.forecastData = data
        let stringsProvider = ForecastDataStringsProvider(data: data)
        let marker = mapManager?.currentMarker
        marker?.title = stringsProvider.getLocationString()
        marker?.snippet = stringsProvider.getCurrentTemperatureString()
        marker?.userData = data
    }
    
    func didFinishFetchingWithError(_ error: NSError?) { }
}
