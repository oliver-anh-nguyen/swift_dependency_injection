//
//  WeatherViewModelTests.swift
//  DependencyInjectionTests
//
//  Created by AnhNguyen on 20/10/2022.
//

import Foundation
@testable import DependencyInjection
import XCTest

func test_weatherLoaded_temperature() async throws {
    let mock = MockWeatherSerice()
    let weatherVm = WeatherViewModel(weatherFetching: mock)
    
    await weatherVm.weatherForCity(.london)
    
    XCTAssertEqual(weatherVm.temperature, 9.4)
}
