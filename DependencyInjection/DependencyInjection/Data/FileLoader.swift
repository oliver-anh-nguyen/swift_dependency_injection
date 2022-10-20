//
//  FileLoader.swift
//  DependencyInjection
//
//  Created by AnhNguyen on 20/10/2022.
//

import Foundation

class FileLoader {
    static func readLocalFile(_ filename: String) -> Data? {
        guard let file = Bundle.main.path(forResource: filename, ofType: "json") else {
            fatalError("Unable to locate file \"\(filename)\" in main bundle.")
        }
        
        do {
            return try String(contentsOfFile: file).data(using: .utf8)
        } catch {
            fatalError("Unable to load \"\(filename)\" from main bundle:\n\(error)")
        }
    }
    
    static func loadJson(_ data: Data) -> WeatherRawData {
        do {
            return try JSONDecoder().decode(WeatherRawData.self, from: data)
        } catch {
            fatalError("Unable to decode  \"\(data)\" as \(WeatherRawData.self):\n\(error)")
        }
    }
}
