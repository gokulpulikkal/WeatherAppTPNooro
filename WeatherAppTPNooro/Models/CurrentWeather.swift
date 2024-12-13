//
//  CurrentWeather.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/11/24.
//

import Foundation

struct CurrentWeather: Codable, Identifiable {
    
    var id: String
    var location: Location
    var current: WeatherDetails?
    
    init(location: Location, current: WeatherDetails? = nil) {
        self.id = UUID().uuidString
        self.location = location
        self.current = current
    }

    private enum CodingKeys: String, CodingKey {
        case location
        case current
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID().uuidString
        self.location = try container.decode(Location.self, forKey: .location)
        self.current = try container.decodeIfPresent(WeatherDetails.self, forKey: .current)
    }
}

// MARK: - Equatable, Hashable

extension CurrentWeather: Equatable, Hashable {
    static func == (lhs: CurrentWeather, rhs: CurrentWeather) -> Bool {
        lhs.id == rhs.id && lhs.location == rhs.location && lhs.current == rhs.current
    }

    func hash(into hasher: inout Hasher) {
        // Combine the hash values of the location and current properties
        hasher.combine(location)
        hasher.combine(current)
    }
}
