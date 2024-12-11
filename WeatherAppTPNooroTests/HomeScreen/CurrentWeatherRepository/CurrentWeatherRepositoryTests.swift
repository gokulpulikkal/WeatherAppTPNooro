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

    var httpClient: any HTTPClientProtocol
    var currentWeatherRepository: any CurrentWeatherRepositoryProtocol

    init() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        URLProtocolMock.mockResponses = [:]
        let urlSession = URLSession(configuration: config)
        self.httpClient = HTTPClient(session: urlSession)
        self.currentWeatherRepository = CurrentWeatherRepository(httpClient: httpClient)
    }

    @Test
    func gettingCurrentWeather() async throws {
        // Setting up the network layer to return something
        let currentWeatherRequestData = WeatherRequestData.currentWeather(location: "buffalo")
        let request = try httpClient.getRequest(requestData: currentWeatherRequestData)
        URLProtocolMock.mockResponses[request.url!] = (
            data: CurrentWeatherMockData.sampleBuffaloWeatherData,
            response: nil,
            error: nil
        )

        let expectedResponse = CurrentWeatherMockData.sampleBuffaloWeather

        // Testing the actual implementation
        let returnedResult = try await currentWeatherRepository.currentWeather(cityName: "buffalo")

        #expect(returnedResult == expectedResponse)
    }

    @Test
    func noResultForCityName() async throws {
        let cityName = "noName"
        let currentWeatherRequestData = WeatherRequestData.currentWeather(location: cityName)
        let request = try httpClient.getRequest(requestData: currentWeatherRequestData)
        let expectedError = RequestError.noResponse
        URLProtocolMock.mockResponses[request.url!] = (data: nil, response: nil, error: expectedError)

        await #expect(performing: {
            try await currentWeatherRepository.currentWeather(cityName: cityName)
        }, throws: { error in
            expectedError.localizedDescription == error.localizedDescription
        })
    }

    @Test
    func parsingError() async throws {
        let cityName = "errorCity"
        let currentWeatherRequestData = WeatherRequestData.currentWeather(location: cityName)
        let request = try httpClient.getRequest(requestData: currentWeatherRequestData)
        URLProtocolMock.mockResponses[request.url!] = (
            data: CurrentWeatherMockData.sampleErrorData,
            response: nil,
            error: RequestError.decode
        )
        await #expect(performing: {
            try await currentWeatherRepository.currentWeather(cityName: cityName)
        }, throws: { _ in
            // If there is an error that is it for this test
            true
        })
    }

}
