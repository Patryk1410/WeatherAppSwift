//
//  ViewController.swift
//  WeatherApp
//
//  Created by patryk on 04.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let lodzLocationId : String = "3093133"
    
    var handler: HttpHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.handler = HttpClient(baseURL: "http://api.openweathermap.org/data/")
        let request = WeatherByIdRequest(locationId: lodzLocationId)
        
        self.handler?.make(request: request, completion: { (result, error) in
            print(result ?? "error")
        })
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

