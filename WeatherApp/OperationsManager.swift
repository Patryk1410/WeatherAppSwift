//
//  OperationsManager.swift
//  WeatherApp
//
//  Created by patryk on 21.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit

enum DownloadState {
    case New, Downloaded, Failed
}

class OperationManager: NSObject {
//    lazy var downloadsInProgress = [Operation]()
    lazy var downloadQueue:OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Download queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
}
