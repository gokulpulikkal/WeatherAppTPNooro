//
//  CurrentWeather.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/11/24.
//

import Foundation

struct CurrentWeather: Codable, Identifiable {
    var id: String {
        UUID().uuidString
    }

    var location: Location
    var current: WeatherDetails?

    private enum CodingKeys: String, CodingKey {
        case location
        case current
    }
}

// MARK: - Equatable, Hashable

extension CurrentWeather: Equatable, Hashable {
    static func == (lhs: CurrentWeather, rhs: CurrentWeather) -> Bool {
        lhs.location == rhs.location && lhs.current == rhs.current
    }

    func hash(into hasher: inout Hasher) {
        // Combine the hash values of the location and current properties
        hasher.combine(location)
        hasher.combine(current)
    }
}
