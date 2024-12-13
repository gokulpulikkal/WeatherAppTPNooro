//
//  CurrentWeatherRepository.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/11/24.
//
import Foundation

/// A repository that manages the retrieval of the current weather for the locations
class CurrentWeatherRepository: CurrentWeatherRepositoryProtocol {

    // MARK: Properties

    /// A http client to get the data from api
    private let httpClient: any HTTPClientProtocol

    // MARK: Initializer

    init(httpClient: any HTTPClientProtocol = HTTPClient()) {
        self.httpClient = httpClient
    }

    // MARK: Functions

    /// returns the current weather for the city
    func currentWeather(cityCoordinates: String) async throws -> CurrentWeather {
        let currentWeatherRequestData = WeatherRequestData.currentWeather(location: cityCoordinates)
        let data = try await httpClient.httpData(from: currentWeatherRequestData)
        let currentWeather = try JSONDecoder().decode(CurrentWeather.self, from: data)
        return currentWeather
    }

    /// Returns current weather for a list of locations
    /// The Current weather for the locations will be a asynchronous stream so the caller site needs to handle the
    /// stream to match the locations with current weather. The order will not be preserved. the current weather is
    /// streamed as it gets the response
    func currentWeathers(for locations: [Location]) -> AsyncThrowingStream<CurrentWeather, Error> {
        AsyncThrowingStream { continuation in
            Task {
                try await withThrowingTaskGroup(of: CurrentWeather.self) { group in
                    for location in locations {
                        group.addTask {
                            try await self.currentWeather(cityCoordinates: "\(location.lat),\(location.lon)")
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
