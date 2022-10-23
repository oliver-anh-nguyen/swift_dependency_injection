//
//  DependencyInjectionApp.swift
//  DependencyInjection
//
//  Created by AnhNguyen on 20/10/2022.
//

import SwiftUI

@main
struct DependencyInjectionApp: App {
    var weatherVm = WeatherViewModel(weatherFetching: WeatherService())
    
    var body: some Scene {
        WindowGroup {
            WeatherView(weatherVm: weatherVm)
        }
    }
}
