//
//  WeatherModel.swift
//  DependencyInjection
//
//  Created by AnhNguyen on 20/10/2022.
//

import Foundation

struct WeatherModel {
    var locationName: String
    var weatherName: String
    var description: String
    var temperature: Double
    var timeOffUtc: Double //timezone Shift in seconds from UTC
    
    init (data: WeatherRawData) {
        locationName = data.name
        weatherName = data.weather.first!.main
        description = data.weather.first!.description
        temperature = data.main.temp
        timeOffUtc = data.timezone
    }
}
