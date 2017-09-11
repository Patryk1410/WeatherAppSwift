//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by patryk on 06.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit
import SDWebImage

class ForecastTableViewCell: UITableViewCell, UITableViewCellLoadableProtocol {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var conditionsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
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
        let stringsProvider: WeatherRecordDataStringsProvider = WeatherRecordDataStringsProvider(data: data)
        
        self.temperatureLabel.text = stringsProvider.getTemperatureString()
        self.minTemperatureLabel.text = stringsProvider.getMinTemperatureString()
        self.maxTemperatureLabel.text = stringsProvider.getMaxTemperatureString()
        self.dateLabel.text = stringsProvider.getDateString()
        self.conditionsLabel.text = stringsProvider.getConditionsString()
        self.descriptionLabel.text = stringsProvider.getConditionsDescriptionString()
        let iconUrl: URL? = URL(string: stringsProvider.getWeatherIconUrl())
        self.weatherImageView.sd_setImage(with: iconUrl, placeholderImage: #imageLiteral(resourceName: "Image"))
    }

}
