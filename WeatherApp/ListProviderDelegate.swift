//
//  ListProviderDelegate.swift
//  WeatherApp
//
//  Created by patryk on 13.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation

public protocol ListProviderDelegate: class {
    
    func didStartFetching(_ data: [TableViewData]?)
    
    func didFinishFetching(_ data: [TableViewData]?)
    
    func didFinishFetchingWithError(_ error: NSError?)
    
}
