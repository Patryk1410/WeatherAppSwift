//
//  HttpHandlerError.swift
//  WeatherApp
//
//  Created by patryk on 04.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation

public enum HttpHandlerError: Error {
    case WrongStatusCode
    case ServerResponseNotParseable
    case NoDataFromServer
    case ServerResponseIsNotUnboxableDictionary
    case WrongUrl
}
