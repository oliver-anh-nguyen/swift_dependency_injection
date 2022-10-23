//
//  ContentView.swift
//  DependencyInjection
//
//  Created by AnhNguyen on 20/10/2022.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var weatherVm: WeatherViewModel
    
    var body: some View {
        VStack {
            VStack {
                Text("Current weather in Cities")
                Button("New York") {
                    Task {
                        await weatherVm.weatherForCity(_:.newyork)
                    }
                }
                Button("Cape Town") {
                    Task {
                        await weatherVm.weatherForCity(_: .capetown)
                    }
                }
            }
            .frame(width: 300)
            
            ContentView(weatherVm: weatherVm)
        }
    }
}

struct ContentView: View {
    @ObservedObject var weatherVm: WeatherViewModel
    
    var body: some View {
        List {
            HStack {
                Text("Location").frame(width: 100, alignment: .trailing).padding(.horizontal)
                Text(weatherVm.location)
            }
            HStack {
                Text("Weather")
                    .frame(width:100, alignment: .trailing).padding(.horizontal)
                Text(weatherVm.weatherMain)
            }
            HStack {
                Text("Description")
                    .frame(width:100, alignment: .trailing).padding(.horizontal)
                Text(weatherVm.description)
            }
            HStack {
                Text("Temperature")
                    .frame(width:100, alignment: .trailing).padding(.horizontal)
                Text("\(weatherVm.temperature)°K")
            }
            HStack {
                Text("Time")
                    .frame(width:100, alignment: .trailing).padding(.horizontal)
                Text(weatherVm.locationTime)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weatherVm: WeatherViewModel(weatherFetching: WeatherService()))
    }
}
