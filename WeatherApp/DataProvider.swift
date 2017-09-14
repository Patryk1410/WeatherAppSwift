//
//  DataProvider.swift
//  WeatherApp
//
//  Created by patryk on 14.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation

public protocol DataProviderProtocol: class {
    
    weak var delegate: DataProviderDelegate? { get set }
    
    func requestData()
    
}

public protocol DataProviderDelegate: class {
    
    func didStartFetching(_ data: [DataObjectProtocol]?)
    
    func didFinishFetching(_ data: [DataObjectProtocol]?)
    
    func didFinishFetchingWithError(_ error: NSError?)
    
}
