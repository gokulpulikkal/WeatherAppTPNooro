//
//  WeatherCondition.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/11/24.
//

import Foundation

struct WeatherCondition: Codable {
    var title: String
    var icon: String
    var code: Double

    private enum CodingKeys: String, CodingKey {
        case title = "text"
        case icon
        case code
    }
}

extension WeatherCondition: Hashable {}
