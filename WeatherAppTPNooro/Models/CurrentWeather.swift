//
//  CurrentWeather.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/11/24.
//

import Foundation

/// A model representing details about current weather of the location
struct CurrentWeather: Codable {

    /// The location object for which the current weather is for
    var location: Location

    /// The weather details object which stores all the metadata
    var current: WeatherDetails?

    // MARK: Codable

    private enum CodingKeys: String, CodingKey {
        case location
        case current
    }
}

// MARK: - Identifiable

extension CurrentWeather: Identifiable {
    /// Computed id property for the object
    /// not obtained from the API. But needed for the identifiable protocol conformance
    var id: String {
        "\(location.name)\(location.country)\(location.region)"
    }
}

// MARK: - Equatable, Hashable

extension CurrentWeather: Equatable, Hashable {
    static func == (lhs: CurrentWeather, rhs: CurrentWeather) -> Bool {
        lhs.id == rhs.id && lhs.current == rhs.current
    }

    func hash(into hasher: inout Hasher) {
        // Combine the hash values of the location and current properties
        hasher.combine(location)
        hasher.combine(current)
    }
}
