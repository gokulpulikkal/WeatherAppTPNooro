//
//  SearchScreenView+ViewModel.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/12/24.
//

import Foundation
import Observation

extension SearchScreenView {

    /// Manages state and logic for the Search screen
    @MainActor @Observable
    class ViewModel {
        // MARK: Dependencies

        /// A data source for the location search operations
        private let searchLocationRepository: any SearchLocationRepositoryProtocol

        /// A data source for the current weather related operations
        private let currentWeatherRepository: any CurrentWeatherRepositoryProtocol

        // MARK: Properties

        /// A state variable that will contain the input text from the search bar text input
        var searchKey = ""

        /// A list that will hold the results of search
        var locationsList: [Location] = []

        /// A list that will hold the current weather details of the locations in the locations list
        var currentWeatherList: [CurrentWeather] = []

        /// variable that will hold the selected location from the search results
        var selectedWeatherLocation: CurrentWeather?

        /// The load state of fetching the user's workout plans.
        var loadState: LoadState<[CurrentWeather], any Error> = .loading

        /// flag to know weather the search is in progress or not
        var isSearchInProgress = false

        /// a variable to hold location search task.
        /// When a locations search task in progress this variable should hold the reference.
        /// This is useful to cancel if a new search query comes
        private var locationsTaskInProgress: Task<Void, Never>?

        /// a variable to hold current weather search for the locations task.
        /// When a current weather  search task in progress this variable should hold the reference.
        /// This is useful to cancel if a new search query comes
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

        /// function that performs the locations search for the given query keyword
        /// This will update the locationsList and currentWeatherList with the returned results
        /// The current weather details then will be asynchronously updated with `getCurrentWeather` function
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
                    if !Task.isCancelled {
                        loadState = .failure(RequestError.unexpectedStatusCode)
                    }
                    isSearchInProgress = false
                }
            }
        }

        /// A private function that will update the current weather for the locations in currentWeatherList
        /// The function uses the rounded lat and lon of the locations already saved in the currentWeatherList as part
        /// of the locations list api. This function uses a parallel asynchronous way for updating the current weather
        /// in the list Note that if the location in the location list and returned location in the current weather
        /// response does not match then the update won't happen
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
                        let roundedLat = (currentWeather.location.lat * 10).rounded(.down) / 10
                        let roundedLon = (currentWeather.location.lon * 10).rounded(.down) / 10

                        // Find the indices of matching locations
                        let matchingIndices = currentWeatherList.enumerated().compactMap { index, weather -> Int? in
                            let roundedWeatherLat = (weather.location.lat * 10).rounded(.down) / 10
                            let roundedWeatherLon = (weather.location.lon * 10).rounded(.down) / 10

                            return (roundedWeatherLat == roundedLat && roundedWeatherLon == roundedLon) ? index : nil
                        }

                        // Update the current property for all matching indices
                        for index in matchingIndices {
                            currentWeatherList[index].current = currentWeather.current
                        }
                    }
                } catch {
                    print("Failed to get currentWeather for all locations \(error.localizedDescription)")
                }
            }
        }

        /// A function that will clear the current state of the search screen
        func clearSearchResults() {
            locationsList = []
            currentWeatherList = []
            loadState = .loading
            searchKey = ""
        }
    }
}
