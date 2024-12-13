//
//  Location.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/11/24.
//

import Foundation

/// A model representing metadata about of the location
struct Location: Codable {

    /// id of the location
    var id: Int?

    /// name of the location
    var name: String

    /// region name of the location
    var region: String

    /// country of the location
    var country: String

    /// latitude of the location
    var lat: Float

    /// longitude of the location
    var lon: Float
}

// MARK: - Equatable

extension Location: Equatable {}

// MARK: - Hashable

extension Location: Hashable {}
