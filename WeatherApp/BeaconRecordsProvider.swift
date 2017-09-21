//
//  BeaconRecordsProvider.swift
//  WeatherApp
//
//  Created by patryk on 20.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation

class BeaconRecordsProvider: DataProviderProtocol {
    var delegate: DataProviderDelegate?
    
    func requestData() {
        guard let beaconRecords = BeaconRecordMO.all() as? [BeaconRecordMO] else {
            return
        }
        let data = beaconRecords.map({ (beaconRecord) -> BeaconRecordData in
            return BeaconRecordData(beaconRecord: beaconRecord)
        })
        self.delegate?.didFinishFetching(data)
    }
}
