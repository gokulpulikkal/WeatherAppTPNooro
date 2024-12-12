//
//  SearchScreenView+ViewModel.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/12/24.
//

import Foundation
import Observation

extension SearchScreenView {

    @Observable
    class ViewModel {
        // MARK: Dependencies

        private let searchLocationRepository: any SearchLocationRepositoryProtocol

        private let currentWeatherRepository: any CurrentWeatherRepositoryProtocol

        // MARK: Properties

        var locationsList: [Location] = []
        var currentWeatherList: [CurrentWeather] = []

        /// The load state of fetching the user's workout plans.
        var loadState: LoadState<[CurrentWeather], any Error> = .loading
        var isSearchInProgress = false

        // MARK: Initializer

        init(
            searchLocationRepository: any SearchLocationRepositoryProtocol = SearchLocationRepository(),
            currentWeatherRepository: any CurrentWeatherRepositoryProtocol = CurrentWeatherRepository()
        ) {
            self.searchLocationRepository = searchLocationRepository
            self.currentWeatherRepository = currentWeatherRepository
        }

        // MARK: Functions

        func locations(for keyWord: String) async {
            guard keyWord.count >= 2 else {
                return
            }
            isSearchInProgress = true
            do {
                locationsList = try await searchLocationRepository.getLocations(for: keyWord)
                if !locationsList.isEmpty {
                    currentWeatherList = locationsList.map { location in CurrentWeather(location: location) }
                    isSearchInProgress = false
                    loadState = .success(currentWeatherList)
                } else {
                    loadState = .failure(SearchRequestErrors.noResultError)
                    isSearchInProgress = false
                }
            } catch {
                loadState = .failure(RequestError.unexpectedStatusCode)
                isSearchInProgress = false
            }
        }
        
        private func getCurrentWeather(for locations: [Location]) async {
            do {
                
            } catch {
                print("Failed to get currentWeather for all locations \(error.localizedDescription)")
            }
        }
        
        func clearSearchResults() {
            locationsList = []
            currentWeatherList = []
        }
    }
}