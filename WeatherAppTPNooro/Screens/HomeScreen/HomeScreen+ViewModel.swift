//
//  HomeScreen+ViewModel.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/11/24.
//

import Foundation
import Observation

extension HomeScreen {

    @Observable
    class ViewModel {
        // MARK: Dependencies

        private let currentWeatherRepository: CurrentWeatherRepositoryProtocol

        // MARK: Properties

        /// The load state of fetching the user's workout plans.
        var loadState: LoadState<CurrentWeather, any Error> = .loading

        // MARK: Initializer

        init(currentWeatherRepository: CurrentWeatherRepositoryProtocol = CurrentWeatherRepository()) {
            self.currentWeatherRepository = currentWeatherRepository
        }

        // MARK: Functions

        func getCurrentWeather(for cityCoordinates: String) async {
            do {
                loadState = .loading
                let currentWeather = try await currentWeatherRepository.currentWeather(cityCoordinates: cityCoordinates)
                loadState = .success(currentWeather)
            } catch {
                loadState = .failure(error)
            }
        }
    }
}
