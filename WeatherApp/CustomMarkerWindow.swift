//
//  CustomMarkerWindow.swift
//  WeatherApp
//
//  Created by patryk on 14.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit

class CustomMarkerWindow: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    static func loadView() -> CustomMarkerWindow?{
        let customInfoWindow = Bundle.main.loadNibNamed(customMarkerWindowName, owner: self, options: nil)?[0] as? CustomMarkerWindow ?? nil
        return customInfoWindow
    }
}
