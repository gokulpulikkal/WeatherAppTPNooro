//
//  CurrentWeatherRepositoryProtocol.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/11/24.
//

import Foundation

protocol CurrentWeatherRepositoryProtocol {

    /// returns the current weather for the city
    func currentWeather(cityName: String) async throws -> CurrentWeather

    /// Returns current weather for a list of locations
    func currentWeathers(for locations: [Location]) -> AsyncThrowingStream<CurrentWeather, Error>
}
