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

    func currentWeathers(for locations: [Location]) -> AsyncThrowingStream<CurrentWeather, Error> {
        AsyncThrowingStream { continuation in
            Task {
                try await withThrowingTaskGroup(of: CurrentWeather.self) { group in
                    for location in locations {
                        group.addTask {
                            try await self.currentWeather(cityName: location.name)
                        }
                    }

                    for try await currentWeather in group {
                        continuation.yield(currentWeather)
                    }
                    continuation.finish()
                }
            }
        }
    }
}
