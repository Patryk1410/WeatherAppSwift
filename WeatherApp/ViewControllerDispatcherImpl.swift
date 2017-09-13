//
//  ViewControllerDispatcher.swift
//  WeatherApp
//
//  Created by patryk on 12.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit

class ViewControllerDispatcherImpl: NSObject, ViewControllerDispatcher {
    
    func pushFromStoryboard(_ parent: UIViewController, data: [String: Any?], destinationViewControllerIdentifier: String, notificationName: String) {
        let storyboard: UIStoryboard = UIStoryboard.init(name: mainStoryboardName, bundle: nil)
        let destinationViewController = storyboard.instantiateViewController(withIdentifier: destinationViewControllerIdentifier) as! BaseViewController
        destinationViewController.initializeData(data: data)
        parent.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    func pushFromXib<T: UIViewController>(_ parent: UIViewController, data: [String: Any?], nibName: String, type: T.Type) {
        let destinationViewController = T(nibName: nibName, bundle: nil) as! BaseViewController
        destinationViewController.initializeData(data: data)
        parent.navigationController?.pushViewController(destinationViewController, animated: true)
    }

}
