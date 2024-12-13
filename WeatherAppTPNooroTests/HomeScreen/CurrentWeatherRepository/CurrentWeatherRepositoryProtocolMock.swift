//
//  CurrentWeatherRepositoryProtocolMock.swift
//  WeatherAppTPNooroTests
//
//  Created by Gokul P on 12/12/24.
//

import Foundation
@testable import WeatherAppTPNooro

protocol CurrentWeatherRepositoryProtocolMock: CurrentWeatherRepositoryProtocol {

    /// Sets the weather response for the city name. Purely for testing
    func setCurrentWeather(cityCoordinates: String, currentWeather: CurrentWeather)

}
