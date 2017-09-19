//
//  LodzCustomMarkerWindow.swift
//  WeatherApp
//
//  Created by patryk on 18.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit
import GoogleMaps

class LodzCustomMarkerWindow: CustomMarkerWindowTemplate {

    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadData(marker: GMSMarker) {
        self.selectedMarker = marker
        guard let forecastData = marker.userData as? ForecastData else {
            return
        }
        let stringsProvider = ForecastDataStringsProvider(data: forecastData)
        self.locationLabel.text = stringsProvider.getLocationString()
        self.temperatureLabel.text = stringsProvider.getCurrentTemperatureString()
    }
    
    @IBAction func didPressShowDetails(_ sender: Any) {
        guard let marker = self.selectedMarker else {
            return
        }
        self.mapDelegate?.didPressShowDetail(marker: marker)
    }
    

    @IBAction func didPressDelete(_ sender: Any) {
        guard let marker = self.selectedMarker else {
            return
        }
        self.mapDelegate?.didPressDelete(marker: marker)
    }
}
