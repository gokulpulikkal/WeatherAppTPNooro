//
//  SearchScreenView+ViewModel.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/12/24.
//

import Foundation
import Observation

extension SearchScreenView {

    @MainActor @Observable
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

        private var locationsTaskInProgress: Task<Void, Never>?
        private var locationsWeatherTaskInProgress: Task<Void, Never>?

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

            locationsTaskInProgress?.cancel()

            isSearchInProgress = true
            locationsTaskInProgress = Task {
                do {
                    locationsList = try await searchLocationRepository.getLocations(for: keyWord)
                    if !locationsList.isEmpty {
                        currentWeatherList = locationsList.map { location in CurrentWeather(location: location) }
                        isSearchInProgress = false

                        if Task.isCancelled {
                            return
                        }

                        loadState = .success(currentWeatherList)
                        await getCurrentWeather(for: locationsList)
                    } else {
                        loadState = .failure(SearchRequestErrors.noResultError)
                        isSearchInProgress = false
                    }
                } catch {
                    if !Task.isCancelled { // Check if the task was cancelled before handling the error
                        loadState = .failure(RequestError.unexpectedStatusCode)
                    }
                    isSearchInProgress = false
                }
            }
        }

        private func getCurrentWeather(for locations: [Location]) async {
            locationsWeatherTaskInProgress?.cancel()

            locationsWeatherTaskInProgress = Task {
                do {
                    for try await currentWeather in currentWeatherRepository.currentWeathers(for: locations) {
                        // Check if the locations list has changed before updating the weather
                        guard !Task.isCancelled, locations == locationsList else {
                            // If locations have changed, discard the current weather data
                            print("Either task cancelled or locations list changed! this result is not longer needed")
                            return
                        }
                        if let locationIndex = currentWeatherList.firstIndex(where: {
                            // Round latitudes and longitudes down to one decimal point before comparing
                            let roundedLat = (currentWeather.location.lat * 10).rounded(.down) / 10
                            let roundedLon = (currentWeather.location.lon * 10).rounded(.down) / 10

                            return ($0.location.lat * 10).rounded(.down) / 10 == roundedLat &&
                                ($0.location.lon * 10).rounded(.down) / 10 == roundedLon
                        }) {
                            currentWeatherList[locationIndex].current = currentWeather.current
                        }
                    }
                } catch {
                    print("Failed to get currentWeather for all locations \(error.localizedDescription)")
                }
            }
        }

        func clearSearchResults() {
            locationsList = []
            currentWeatherList = []
            loadState = .loading
        }
    }
}
