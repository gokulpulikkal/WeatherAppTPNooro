//
//  CurrentWeatherRepositoryProtocol.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/11/24.
//

import Foundation

/// A protocol for types that manage the retrieval of current weather of the location or locations
protocol CurrentWeatherRepositoryProtocol {

    /// returns the current weather for the city
    func currentWeather(cityCoordinates: String) async throws -> CurrentWeather

    /// Returns current weather for a list of locations
    func currentWeathers(for locations: [Location]) -> AsyncThrowingStream<CurrentWeather, Error>
}
