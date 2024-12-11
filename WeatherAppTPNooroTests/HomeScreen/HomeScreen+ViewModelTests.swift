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
        let cityName = "buffalo"
        currentWeatherRepositoryMock.setCurrentWeather(cityName: cityName, currentWeather: CurrentWeatherMockData.sampleBuffaloWeather)
        
        await viewModel.getCurrentWeather(for: cityName)
        
        #expect(viewModel.loadState == .success(CurrentWeatherMockData.sampleBuffaloWeather))
    }
    
    @Test
    func loadStateFail() async throws {
        #expect(viewModel.loadState == .loading)
        let cityName = "ErrorBuffalo"
        
        await viewModel.getCurrentWeather(for: cityName)
        #expect(viewModel.loadState != .success(CurrentWeatherMockData.sampleBuffaloWeather))
        
        #expect(viewModel.loadState == .failure(RequestError.noResponse))
        
    }

}
