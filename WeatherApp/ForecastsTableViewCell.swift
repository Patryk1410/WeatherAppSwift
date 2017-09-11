//
//  ForecastsTableViewCell.swift
//  WeatherApp
//
//  Created by patryk on 06.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit

class ForecastsTableViewCell: UITableViewCell, UITableViewCellLoadableProtocol {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func loadData(_ data: TableViewData, tableview: UITableView) {

        guard let data = data as? ForecastData else {
            return
        }
        let dataStringsProvider = ForecastDataStringsProvider(data: data)
        
        self.locationLabel.text = dataStringsProvider.getLocationString()
        self.dateLabel.text = dataStringsProvider.getDateString()
    }

}
