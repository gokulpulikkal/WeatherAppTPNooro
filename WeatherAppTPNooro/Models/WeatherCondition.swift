//
//  WeatherCondition.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/11/24.
//

import Foundation

/// A model representing details about current weather condition of the location
struct WeatherCondition: Codable {

    /// condition title
    var title: String

    /// icon url path
    var icon: String

    /// condition code
    var code: Double

    // MARK: Codable

    private enum CodingKeys: String, CodingKey {
        case title = "text"
        case icon
        case code
    }
}

// MARK: - Hashable

extension WeatherCondition: Hashable {}
