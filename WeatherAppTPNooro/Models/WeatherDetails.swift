//
//  WeatherDetails.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/11/24.
//

import Foundation

struct WeatherDetails: Codable {
    var temperatureCelsius: Double
    var temperatureFahrenheit: Double
    var isDay: Double
    var condition: WeatherCondition
    var humidity: Double
    var feelsLikeCelsius: Double
    var feelsLikeFahrenheit: Double
    var uvIndex: Double

    enum CodingKeys: String, CodingKey {
        case temperatureCelsius = "temp_c"
        case temperatureFahrenheit = "temp_f"
        case isDay = "is_day"
        case condition
        case humidity
        case feelsLikeCelsius = "feelslike_c"
        case feelsLikeFahrenheit = "feelslike_f"
        case uvIndex = "uv"
    }
}

// MARK: - Equatable

extension WeatherDetails: Equatable, Hashable {
    static func == (lhs: WeatherDetails, rhs: WeatherDetails) -> Bool {
        return lhs.temperatureCelsius == rhs.temperatureCelsius && lhs.humidity == rhs.humidity
    }
}
