//
//  SearchLocationRepositoryTests.swift
//  WeatherAppTPNooroTests
//
//  Created by Gokul P on 12/12/24.
//

import Testing
@testable import WeatherAppTPNooro

struct SearchLocationRepositoryTests {

    @Test
    func gettingSuccessfulResponse() async throws {
        let httpClientMock = HTTPClientMock()
        let searchLocationRepository = SearchLocationRepository(httpClient: httpClientMock)
        
        let keyword = "lond"
        httpClientMock.setImplementation(handler: {
            LocationsMockData.sampleCitiesData
        })

        let expectedResponse = LocationsMockData.sampleCities
        let returnedResult = try await searchLocationRepository.getLocations(for: keyword)

        #expect(returnedResult == expectedResponse)
    }

    @Test
    func noResultForKeyWord() async throws {
        let httpClientMock = HTTPClientMock()
        let searchLocationRepository = SearchLocationRepository(httpClient: httpClientMock)
        
        let keyword = ""
        let expectedError = RequestError.noResponse
        await #expect(performing: {
            try await searchLocationRepository.getLocations(for: keyword)
        }, throws: { error in
            expectedError.localizedDescription == error.localizedDescription
        })
    }

    @Test
    func parsingError() async throws {
        let httpClientMock = HTTPClientMock()
        let searchLocationRepository = SearchLocationRepository(httpClient: httpClientMock)
        
        let keyword = "errorCity"
        httpClientMock.setImplementation(handler: {
            LocationsMockData.sampleErrorData
        })

        await #expect(performing: {
            try await searchLocationRepository.getLocations(for: keyword)
        }, throws: { _ in
            // If there is an error that is it for this test
            true
        })
    }
}
