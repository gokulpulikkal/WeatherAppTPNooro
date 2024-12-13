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

    func setCurrentWeather(cityCoordinates: String, currentWeather: CurrentWeather) {
        mockCurrentWeather[cityCoordinates] = currentWeather
    }

    func currentWeather(cityCoordinates: String) async throws -> WeatherAppTPNooro.CurrentWeather {
        if mockCurrentWeather[cityCoordinates] != nil {
            return mockCurrentWeather[cityCoordinates]!
        } else {
            throw RequestError.unknown
        }
    }
    
    func currentWeathers(for locations: [WeatherAppTPNooro.Location]) -> AsyncThrowingStream<WeatherAppTPNooro.CurrentWeather, any Error> {
        AsyncThrowingStream { continuation in
            
        }
    }
}
