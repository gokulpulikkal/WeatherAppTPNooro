//
//  HomeScreen+ViewModel.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/11/24.
//

import Foundation
import Observation

extension HomeScreen {

    /// Manages state and logic for the HomeScreen
    @Observable
    class ViewModel {
        // MARK: Dependencies

        /// Data source for the current weather related queries
        private let currentWeatherRepository: CurrentWeatherRepositoryProtocol

        // MARK: Properties

        /// The load state of fetching the current weather for the selected location
        var loadState: LoadState<CurrentWeather, any Error> = .loading

        // MARK: Initializer

        init(currentWeatherRepository: CurrentWeatherRepositoryProtocol = CurrentWeatherRepository()) {
            self.currentWeatherRepository = currentWeatherRepository
        }

        // MARK: Functions

        /// Retrieves the current weather for the city coordinates string
        func getCurrentWeather(for selectedCityId: Int) async {
            do {
                loadState = .loading
                let currentWeather = try await currentWeatherRepository.currentWeather(selectedCityId: selectedCityId)
                loadState = .success(currentWeather)
            } catch {
                loadState = .failure(error)
            }
        }
    }
}
