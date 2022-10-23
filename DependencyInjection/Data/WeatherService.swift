//
//  WeatherService.swift
//  DependencyInjection
//
//  Created by AnhNguyen on 20/10/2022.
//

import Foundation
import CoreLocation
class WeatherService: WeatherFetching {
    func fetchCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> WeatherRawData {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "AppId") as? String else {
            fatalError("AppId must not be empty in plist")
        }
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=metric&appid=\(apiKey)") else {
            fatalError("Missing url")
        }
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error retrieving weather data")
        }
        
        return FileLoader.loadJson(data)
    }
}
