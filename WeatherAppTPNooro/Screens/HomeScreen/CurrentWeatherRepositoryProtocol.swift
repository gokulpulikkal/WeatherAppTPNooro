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

}

protocol CurrentWeatherRepositoryProtocolMock: CurrentWeatherRepositoryProtocol {

    /// Sets the weather response for the city name. Purely for testing
    func setCurrentWeather(cityName: String, currentWeather: CurrentWeather)

    func currentWeather(cityName: String) async throws -> CurrentWeather

}
