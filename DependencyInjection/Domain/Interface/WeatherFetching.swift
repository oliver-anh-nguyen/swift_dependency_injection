//
//  WeatherFetching.swift
//  DependencyInjection
//
//  Created by AnhNguyen on 20/10/2022.
//

import Foundation
import CoreLocation

protocol WeatherFetching {
    func fetchCurrentWeather(latitude: CLLocationDegrees,
                                  longitude: CLLocationDegrees) async throws -> WeatherRawData
}
