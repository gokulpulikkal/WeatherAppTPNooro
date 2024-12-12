//
//  CurrentWeatherRepositoryMock.swift
//  WeatherAppTPNooroTests
//
//  Created by Gokul P on 12/11/24.
//

import Foundation
@testable import WeatherAppTPNooro

class CurrentWeatherRepositoryMock: CurrentWeatherRepositoryProtocolMock {

    var mockCurrentWeather: [String: WeatherAppTPNooro.CurrentWeather] = [:]

    func setCurrentWeather(cityName: String, currentWeather: CurrentWeather) {
        mockCurrentWeather[cityName] = currentWeather
    }

    func currentWeather(cityName: String) async throws -> WeatherAppTPNooro.CurrentWeather {
        if mockCurrentWeather[cityName] != nil {
            return mockCurrentWeather[cityName]!
        } else {
            throw RequestError.unknown
        }
    }
}
