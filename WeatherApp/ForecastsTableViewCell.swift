//
//  ForecastsTableViewCell.swift
//  WeatherApp
//
//  Created by patryk on 06.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit

class ForecastsTableViewCell: UITableViewCell {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
//    var forecast: ForecastMO?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
