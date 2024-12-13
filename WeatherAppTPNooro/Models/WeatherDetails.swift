//
//  WeatherDetails.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/11/24.
//

import Foundation

/// A model representing details about current weather of the location
struct WeatherDetails: Codable {

    /// temperature in celcius
    var temperatureCelsius: Double

    /// temperature in Fahrenheit
    var temperatureFahrenheit: Double

    /// value indicating weather it is day time or not in the location
    var isDay: Double

    /// weather condition object
    var condition: WeatherCondition

    /// Humidity value
    var humidity: Double

    /// Feels like temperature in Celsius
    var feelsLikeCelsius: Double

    /// Feels like temperature in Fahrenheit
    var feelsLikeFahrenheit: Double

    /// UVindex value
    var uvIndex: Double

    // MARK: Codable

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

// MARK: - Equatable, Hashable

extension WeatherDetails: Equatable, Hashable {
    static func == (lhs: WeatherDetails, rhs: WeatherDetails) -> Bool {
        lhs.temperatureCelsius == rhs.temperatureCelsius && lhs.humidity == rhs.humidity
    }
}
