//
//  HomeScreen+ViewModelTests.swift
//  WeatherAppTPNooroTests
//
//  Created by Gokul P on 12/11/24.
//

import Testing
@testable import WeatherAppTPNooro

struct HomeScreen_ViewModelTests {
    
    let viewModel: HomeScreen.ViewModel
    var currentWeatherRepositoryMock: CurrentWeatherRepositoryProtocolMock
    
    init() {
        currentWeatherRepositoryMock =  CurrentWeatherRepositoryMock()
        self.viewModel = HomeScreen.ViewModel(currentWeatherRepository: currentWeatherRepositoryMock)
    }

    @Test
    func testInitialLoadState() async throws {
        #expect(viewModel.loadState == .loading)
    }
    
    @Test
    func loadStateUpdate() async throws {
        #expect(viewModel.loadState == .loading)
        let selectedCityId = 23243
        currentWeatherRepositoryMock.setCurrentWeather(selectedCityId: selectedCityId, currentWeather: CurrentWeatherMockData.sampleBuffaloWeather)
        
        await viewModel.getCurrentWeather(for: selectedCityId)
        
        #expect(viewModel.loadState == .success(CurrentWeatherMockData.sampleBuffaloWeather))
    }
    
    @Test
    func loadStateFail() async throws {
        #expect(viewModel.loadState == .loading)
        let selectedCityId = 232
        
        await viewModel.getCurrentWeather(for: selectedCityId)
        #expect(viewModel.loadState != .success(CurrentWeatherMockData.sampleBuffaloWeather))
        
        #expect(viewModel.loadState == .failure(RequestError.noResponse))
        
    }

}
