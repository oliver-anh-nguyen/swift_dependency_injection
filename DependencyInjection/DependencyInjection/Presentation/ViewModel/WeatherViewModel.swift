//
//  WeatherViewModel.swift
//  DependencyInjection
//
//  Created by AnhNguyen on 20/10/2022.
//

import Foundation

class WeatherViewModel: ObservableObject {
    private var weatherService: WeatherFetching
    
    @Published private var weatherModel: WeatherModel
    private(set) var _city: String
    
    init(weatherFetching: WeatherFetching) {
        guard let data = FileLoader.readLocalFile("data") else {
            fatalError("Unable to locate file \"weatherData.json\" in main bundle.")
        }
        
        let rawWeather = FileLoader.loadJson(data)
        weatherModel = WeatherModel(data: rawWeather)
        weatherService = weatherFetching
        _city = "not set"
    }
    
    var location: String {
        get { weatherModel.locationName }
    }
    
    var weatherMain: String {
        get { weatherModel.weatherName }
    }
    
    var description: String {
        get { weatherModel.description }
    }
    
    var temperature: Double {
        get { weatherModel.temperature }
    }
    
    var locationTime: String {
        get {
            let utcDateFormatter = DateFormatter()
            utcDateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            utcDateFormatter.timeStyle = .medium
            let now = Date().addingTimeInterval(weatherModel.timeOffUtc)
            let dateString = utcDateFormatter.string(from: now)
            return dateString
        }
    }
    
    var city: String {
        get {return _city}
    }

    @MainActor
    func weatherForCity(_ c: City) async {
        _city = c.rawValue
        let (lat, lon) = coordinates(for: c)
        
        do {
            let rawWeather = try await weatherService.fetchCurrentWeather(latitude: lat, longitude: lon)
            weatherModel = WeatherModel(data: rawWeather)
        } catch {
            print("Error fetching weather with '\(c.rawValue)' City:\n \(error)")
        }
    }
    
    private func coordinates(for city: City) -> (Double, Double) {
            switch city {
            case .newyork:
                return (40.749939623101724, -73.98584035140507)
            case .london:
                return  (51.48403374752388, -0.0059268752163408114)
            case .paris:
                return  (48.8619958275662, 2.294848578874564)
            case .vancouver:
                return  (49.2791749376975, -123.10359944424778)
            case .capetown:
                return  (-33.96475307519853, 18.417554193804826)
            case .sydney:
                return  (-33.85657055055687, 151.21537180010895)
            }
        }
}

enum City: String, CaseIterable, Identifiable {
    var id: Self { self }
    case newyork = "New York"
    case london = "London"
    case paris = "Paris"
    case vancouver = "Vancouver"
    case capetown = "Cape Town"
    case sydney = "Sydney"
}
