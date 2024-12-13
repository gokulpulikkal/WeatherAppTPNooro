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

    @Test
    func gettingCurrentWeather() async throws {
        let httpClientMock = HTTPClientMock()
        let currentWeatherRepository = CurrentWeatherRepository(httpClient: httpClientMock)
        // Setting up the network layer to return something
        let selectedCityId = 1234
        httpClientMock.setImplementation(handler: {
            CurrentWeatherMockData.sampleBuffaloWeatherData
        })

        let expectedResponse = CurrentWeatherMockData.sampleBuffaloWeather

        // Testing the actual implementation
        let returnedResult = try await currentWeatherRepository.currentWeather(selectedCityId: selectedCityId)

        #expect(returnedResult == expectedResponse)
    }

    @Test
    func noResultForCityName() async throws {
        let httpClientMock = HTTPClientMock()
        let currentWeatherRepository = CurrentWeatherRepository(httpClient: httpClientMock)

        let selectedCityId = 394
        let expectedError = RequestError.noResponse

        await #expect(performing: {
            try await currentWeatherRepository.currentWeather(selectedCityId: selectedCityId)
        }, throws: { error in
            expectedError.localizedDescription == error.localizedDescription
        })
    }

    @Test
    func parsingError() async throws {
        let httpClientMock = HTTPClientMock()
        let currentWeatherRepository = CurrentWeatherRepository(httpClient: httpClientMock)

        let selectedCityId = 22322
        httpClientMock.setImplementation(handler: {
            CurrentWeatherMockData.sampleErrorData
        })

        await #expect(performing: {
            try await currentWeatherRepository.currentWeather(selectedCityId: selectedCityId)
        }, throws: { _ in
            // If there is an error that is it for this test
            true
        })
    }

}
