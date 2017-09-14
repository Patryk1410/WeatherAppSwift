//
//  ListProviderProtocol.swift
//  WeatherApp
//
//  Created by patryk on 13.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation

public protocol ListProviderProtocol: class {
    
    weak var delegate: ListProviderDelegate? { get set }
    
    func requestData()
    
}
