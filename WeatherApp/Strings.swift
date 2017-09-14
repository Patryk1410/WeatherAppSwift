//
//  Strings.swift
//  WeatherApp
//
//  Created by patryk on 11.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation

//MARK: Reuse identifiers
let forecastTableViewCellReuseIdentifier: String = "WeatherApp.ForecastTableViewCell"
let forecastsTableViewCellReuseIdentifier: String = "WeatherApp.ForecastsTableViewCell"

//MARK: Errors
let noDateError: String = "date unavailable"
let noCityError: String = "city unavailable"
let noCountryError: String = "country unavailable"
let noIconError: String = ""
let generalError: String = "-"

//MARK: Other
let degreesCelcius: String = "°C"
let minStr: String = "Min: "
let maxStr: String = "Max: "

//MARK: Storyboard
let mainStoryboardName: String = "Main"

//MARK: Xib names
let forecastChartViewControllerName: String = "ForecastChartViewController"
let mapViewControllerName: String = "MapViewController"
let customMarkerWindowName: String = "CustomMarkerWindow"

//MARK: View controllers identifiers
let forecastTableViewControllerIdentifier: String = "ForecastVC"
let forecastsTableViewControllerIdentifier: String = "ForecastsVC"

//MARK: Weather API
let baseURL: String = "http://api.openweathermap.org/"
let forecastById: String = "data/2.5/forecast?id="
let forecastByLatAndLong: String = "data/2.5/forecast?lat="
let degreeUnit: String = "&units="
let apiKeyUrl: String = "&APPID="
let iconUrl: String = "img/w/"
let pngExtension: String = ".png"
let lodzLocationID = "3093133"
let apiKey = "38dfeb5e38512ca3433ae28e0391b066"
let longUrl = "&lon="
let celcius = "metric"
let farenheit = "imperial"

//MARK: Map API
let mapApiKey = "AIzaSyCKb0IlbdpocPe3oWeb8qqWTt86AxITfdQ"

//MARK: Unboxing Keys
let weatherRecordsKey = "list"
let locationKey = "city"
let dateKey = "dt_txt"
let temperatureKeyPath = "main.temp"
let minTemperatureKeyPath = "main.temp_min"
let maxTemperatureKeyPath = "main.temp_max"
let pressureKeyPath = "main.pressure"
let humidityKeyPath = "main.humidity"
let conditionsKeyPath = "weather.0.main"
let conditionsDescriptionKeyPath = "weather.0.description"
let iconIdKeyPath = "weather.0.icon"
let cloudinessKeyPath = "clouds.all"
let windSpeedKeyPath = "wind.speed"
let countryKey = "country"
let cityKey = "name"
let cityIdKey = "id"
let fromKey = "list.0.dt_txt"

//MARK: Http methods
let httpGet = "GET"

//MARK: Notification names
let initializeForecastTableViewNotification: String = "initializeForecastTableViewController"
let viewControllerLoadedNotification: String = "viewControllerLoaded"

//MARK: View controller data keys
let forecastDataKey: String = "forecast_key"
let weatherRecordsDataKey: String = "weather_records"

//MARK: Tab titles
let forecastsTabTitle: String = "Forecasts"
let mapTabTitle: String = "Map"
