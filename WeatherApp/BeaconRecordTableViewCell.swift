//
//  BeaconRecordTableViewCell.swift
//  WeatherApp
//
//  Created by patryk on 20.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit

class BeaconRecordTableViewCell: UITableViewCell, UITableViewCellLoadableProtocol {

    @IBOutlet weak var beaconLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func loadData(_ data: DataObjectProtocol, tableview: UITableView) {
        guard let data = data as? BeaconRecordData else {
            return
        }
        let stringsProvider = BeaconRecordDataStringsProvider(data: data)
        self.beaconLabel.text = stringsProvider.getBeaconDescriptionString()
        self.locationLabel.text = stringsProvider.getLocationString()
        self.dateLabel.text = stringsProvider.getDateString()
    }
    
}
