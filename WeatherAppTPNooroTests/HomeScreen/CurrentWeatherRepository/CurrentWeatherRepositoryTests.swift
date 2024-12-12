//
//  CurrentWeatherRepositoryTests.swift
//  WeatherAppTPNooroTests
//
//  Created by Gokul P on 12/11/24.
//

import Foundation
import Testing
@testable import WeatherAppTPNooro

struct CurrentWeatherRepositoryTests {

    var httpClientMock: any HTTPClientProtocolMock
    var currentWeatherRepository: any CurrentWeatherRepositoryProtocol

    init() {
        self.httpClientMock = HTTPClientMock()
        self.currentWeatherRepository = CurrentWeatherRepository(httpClient: httpClientMock)
    }

    @Test
    func gettingCurrentWeather() async throws {
        // Setting up the network layer to return something
        let cityName = "buffalo"
        httpClientMock.setImplementation(handler: {
            CurrentWeatherMockData.sampleBuffaloWeatherData
        })

        let expectedResponse = CurrentWeatherMockData.sampleBuffaloWeather

        // Testing the actual implementation
        let returnedResult = try await currentWeatherRepository.currentWeather(cityName: cityName)

        #expect(returnedResult == expectedResponse)
    }

    @Test
    func noResultForCityName() async throws {
        let cityName = "noName"
        let expectedError = RequestError.noResponse

        await #expect(performing: {
            try await currentWeatherRepository.currentWeather(cityName: cityName)
        }, throws: { error in
            expectedError.localizedDescription == error.localizedDescription
        })
    }

    @Test
    func parsingError() async throws {
        let cityName = "errorCity"
        httpClientMock.setImplementation(handler: {
            CurrentWeatherMockData.sampleErrorData
        })

        await #expect(performing: {
            try await currentWeatherRepository.currentWeather(cityName: cityName)
        }, throws: { _ in
            // If there is an error that is it for this test
            true
        })
        URLProtocolMock.clearMockResponses()
    }

}
