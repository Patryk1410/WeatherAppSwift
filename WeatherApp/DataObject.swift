//
//  DataObject.swift
//  WeatherApp
//
//  Created by patryk on 14.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation
import UIKit

public protocol DataObjectProtocol {
    
    func reuseID() -> String
    
    func height() -> CGFloat
    
}
