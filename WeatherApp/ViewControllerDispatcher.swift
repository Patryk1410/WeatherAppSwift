//
//  ViewControllerDispatcher.swift
//  WeatherApp
//
//  Created by patryk on 12.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit

protocol ViewControllerDispatcher {
    
    func pushFromStoryboard(_ parent: UIViewController, data: [String: Any?], destinationViewControllerIdentifier: String, notificationName: String)
    
    func pushFromXib<T: BaseViewController>(_ parent: UIViewController, data: [String: Any?], nibName: String, type: T.Type)
}
