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
    var lat: Float
    var lon: Float
}

// MARK: - Equatable

extension Location: Equatable {}
extension Location: Hashable {}
