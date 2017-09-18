//
//  CustomMarkerWindow.swift
//  WeatherApp
//
//  Created by patryk on 14.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit
import GoogleMaps

class CustomMarkerWindow: UIView {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var selectedMarker: GMSMarker?
    
    weak var mapDelegate: MapManagerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    static func loadView() -> CustomMarkerWindow?{
        let customInfoWindow = Bundle.main.loadNibNamed(customMarkerWindowName, owner: self, options: nil)?[0] as? CustomMarkerWindow ?? nil
        let opaqueWhite = UIColor(white: 1, alpha: 0.85)
        customInfoWindow?.layer.backgroundColor = opaqueWhite.cgColor
        customInfoWindow?.layer.cornerRadius = 8
        return customInfoWindow
    }
    
    func loadData(marker: GMSMarker) {
        self.selectedMarker = marker
        guard let forecastData = marker.userData as? ForecastData else {
            return
        }
        let stringsProvider = ForecastDataStringsProvider(data: forecastData)
        self.locationLabel.text = stringsProvider.getLocationString()
        self.temperatureLabel.text = stringsProvider.getCurrentTemperatureString()
    }
    
    @IBAction func handleShowDetails(_ sender: Any) {
        guard let marker = self.selectedMarker else {
            return
        }
        self.mapDelegate?.didPressShowDetail(marker: marker)
    }
    
    @IBAction func handleDelete(_ sender: Any) {
        guard let marker = self.selectedMarker else {
            return
        }
        self.mapDelegate?.didPressDelete(marker: marker)
    }
}
