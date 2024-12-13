//
//  CurrentWeatherRepositoryMock.swift
//  WeatherAppTPNooroTests
//
//  Created by Gokul P on 12/11/24.
//

import Foundation
@testable import WeatherAppTPNooro

class CurrentWeatherRepositoryMock: CurrentWeatherRepositoryProtocolMock {
    
    
    var mockCurrentWeather: [Int: WeatherAppTPNooro.CurrentWeather] = [:]

    func setCurrentWeather(selectedCityId: Int, currentWeather: CurrentWeather) {
        mockCurrentWeather[selectedCityId] = currentWeather
    }

    func currentWeather(selectedCityId: Int) async throws -> WeatherAppTPNooro.CurrentWeather {
        if mockCurrentWeather[selectedCityId] != nil {
            return mockCurrentWeather[selectedCityId]!
        } else {
            throw RequestError.unknown
        }
    }
    
    func currentWeathers(for locations: [WeatherAppTPNooro.Location]) -> AsyncThrowingStream<WeatherAppTPNooro.CurrentWeather, any Error> {
        AsyncThrowingStream { continuation in
            
        }
    }
}
