//
//  Location.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/11/24.
//

import Foundation

struct Location: Codable {
    var name: String
    var region: String
    var country: String
    var lat: Double
    var lon: Double
}

// MARK: - Equatable

extension Location: Equatable {}
