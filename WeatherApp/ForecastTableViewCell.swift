//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by patryk on 06.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit


class WeatherRecordData : TableViewData {
    
    let temperature: String
    let minTemperature: String
    let maxTemperature: String
    let conditions: String
    let conditionsDescription: String
    let date: String
    
    init(weatherRecord: WeatherRecordMO) {
        self.temperature = weatherRecord.temperature.description 
        self.minTemperature = weatherRecord.minTemperature.description
        self.maxTemperature = weatherRecord.maxTemperature.description
        self.conditions = weatherRecord.conditions ?? "-"
        self.conditionsDescription = weatherRecord.conditionsDescription ?? "-"
        self.date = weatherRecord.date ?? "-"
    }
    
    func reuseID() -> String {
        return "WeatherApp.ForecastTableViewCell"
    }
    
    func height() -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

class ForecastTableViewCell: UITableViewCell, UITableViewCellLoadableProtocol {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var conditionsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func loadData(_ data: TableViewData, tableview: UITableView) {
        guard let data = data as? WeatherRecordData else {
            return
        }
        
        self.temperatureLabel.text = data.temperature + "°C"
        self.minTemperatureLabel.text = "Min: " + data.minTemperature + "°C"
        self.maxTemperatureLabel.text = "Max: " + data.maxTemperature + "°C"
        self.dateLabel.text = data.date
        self.conditionsLabel.text = data.conditions
        self.descriptionLabel.text = data.conditionsDescription
    }

}
