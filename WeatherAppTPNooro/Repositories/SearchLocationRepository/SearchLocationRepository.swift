//
//  SearchLocationRepository.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/12/24.
//

import Foundation

/// A repository that manages the retrieval of list of locations for search queries
class SearchLocationRepository: SearchLocationRepositoryProtocol {

    // MARK: Properties

    /// A http client to get the data from api
    private let httpClient: any HTTPClientProtocol

    // MARK: Initializer

    init(httpClient: any HTTPClientProtocol = HTTPClient()) {
        self.httpClient = httpClient
    }

    // MARK: Functions

    /// Function that'll return list of locations that matching with the `keyWord`
    func getLocations(for keyWord: String) async throws -> [Location] {
        let locationSearchRequestData = LocationSearchRequestData.searchForLocation(keyWord: keyWord)
        let data = try await httpClient.httpData(from: locationSearchRequestData)
        let locationList = try JSONDecoder().decode([Location].self, from: data)
        return locationList
    }
}
