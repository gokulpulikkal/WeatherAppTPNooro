//
//  CurrentWeatherRepository.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/11/24.
//
import Foundation

class CurrentWeatherRepository: CurrentWeatherRepositoryProtocol {

    /// A http client to get the data from api
    private let httpClient: any HTTPClientProtocol

    init(httpClient: any HTTPClientProtocol = HTTPClient()) {
        self.httpClient = httpClient
    }

    func currentWeather(cityName: String) async throws -> CurrentWeather {
        let currentWeatherRequestData = WeatherRequestData.currentWeather(location: cityName)
        let data = try await httpClient.httpData(from: currentWeatherRequestData)
        let currentWeather = try JSONDecoder().decode(CurrentWeather.self, from: data)
        return currentWeather
    }
}
