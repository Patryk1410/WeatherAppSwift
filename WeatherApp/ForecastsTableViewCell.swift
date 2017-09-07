//
//  ForecastsTableViewCell.swift
//  WeatherApp
//
//  Created by patryk on 06.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit

class ForecastData: TableViewData {
    
    let forecastDate: String
    let city: String
    let country: String
    
    init(forecastMo: ForecastMO) {
        self.forecastDate = forecastMo.from ?? "No-date"
        self.city = forecastMo.location?.city ?? "No-City"
        self.country = forecastMo.location?.country ?? "No-Country"
    }
    
    func reuseID() -> String {
        return "WeatherApp.ForecastsTableViewCell"
    }
    func height() -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

class ForecastsTableViewCell: UITableViewCell, UITableViewCellLoadableProtocol {

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
    
    func loadData(_ data: TableViewData, tableview: UITableView) {

        guard let data = data as? ForecastData else {
            return
        }

        self.locationLabel.text = data.city + ", " + data.country
        self.dateLabel.text = data.forecastDate
        
    }

}
