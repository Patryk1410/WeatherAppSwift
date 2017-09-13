//
//  BaseViewController.swift
//  WeatherApp
//
//  Created by patryk on 12.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit

/**
 Abstract class, do not make instances of it
 */
class BaseViewController: UIViewController {
    
    let viewControllerDispatcher: ViewControllerDispatcher = ViewControllerDispatcherImpl()
    
    func initializeData(data: [String: Any?]) { }
}
