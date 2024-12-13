//
//  SearchScreenView+ViewModelTests.swift
//  WeatherAppTPNooroTests
//
//  Created by Gokul P on 12/12/24.
//

import Testing
@testable import WeatherAppTPNooro

@MainActor
struct SearchScreenView_ViewModelTests {

    let viewModel: SearchScreenView.ViewModel
    var currentWeatherRepositoryMock: CurrentWeatherRepositoryProtocolMock
    var searchLocationRepositoryMock: SearchLocationRepositoryProtocolMock

    init() {
        self.currentWeatherRepositoryMock = CurrentWeatherRepositoryMock()
        self.searchLocationRepositoryMock = SearchLocationRepositoryMock()
        self.viewModel = SearchScreenView.ViewModel(
            searchLocationRepository: searchLocationRepositoryMock,
            currentWeatherRepository: currentWeatherRepositoryMock
        )
    }

    @Test
    func testInitialLoadState() async throws {
        #expect(viewModel.loadState == .loading)
    }

    @Test
    func locationsTest() async throws {
        let expectedLocations = LocationsMockData.sampleCities
        let keyWord = "buffalo"
        searchLocationRepositoryMock.setLocationsResponse(keyWord: keyWord, locations: expectedLocations)
        for location in expectedLocations {
            if let locationId = location.id {
                currentWeatherRepositoryMock.setCurrentWeather(
                    selectedCityId: locationId,
                    currentWeather: CurrentWeatherMockData.sampleBuffaloWeather
                )
            }
        }

        #expect(viewModel.locationsList == [])
        #expect(viewModel.currentWeatherList == [])

        await viewModel.locations(for: keyWord)
        #expect(viewModel.loadState != .failure(RequestError.unexpectedStatusCode))
    }

}
