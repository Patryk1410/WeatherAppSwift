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
    let weatherRecords: [WeatherRecordMO]
    
    init(forecast: ForecastMO) {
        self.forecastDate = forecast.from ?? "No-date"
        self.city = forecast.location?.city ?? "No-City"
        self.country = forecast.location?.country ?? "No-Country"
        self.weatherRecords = forecast.weatherRecords?.array as? [WeatherRecordMO] ?? []
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

        self.locationLabel.text = data.city + ", " + data.country
        self.dateLabel.text = data.forecastDate
    }

}
