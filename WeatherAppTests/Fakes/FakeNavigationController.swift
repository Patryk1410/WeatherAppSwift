//
//  FakeNavigationController.swift
//  WeatherApp
//
//  Created by patryk on 13.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation
import UIKit

class FakeNavigationController: UINavigationController {
    
    var capturedViewController: UIViewController?
    var capturedAnimated: Bool?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.capturedViewController = viewController
        self.capturedAnimated = animated
    }
}
