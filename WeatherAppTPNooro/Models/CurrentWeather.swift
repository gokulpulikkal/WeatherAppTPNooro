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

// MARK: - Equatable

extension CurrentWeather: Equatable {
    static func == (lhs: CurrentWeather, rhs: CurrentWeather) -> Bool {
        lhs.location == rhs.location && lhs.current == rhs.current
    }
}
