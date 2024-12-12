//
//  SearchLocationRepository.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/12/24.
//

import Foundation

class SearchLocationRepository: SearchLocationRepositoryProtocol {

    /// A http client to get the data from api
    private let httpClient: any HTTPClientProtocol

    init(httpClient: any HTTPClientProtocol = HTTPClient()) {
        self.httpClient = httpClient
    }

    func getLocations(for keyWord: String) async throws -> [Location] {
        let locationSearchRequestData = LocationSearchRequestData.searchForLocation(keyWord: keyWord)
        let data = try await httpClient.httpData(from: locationSearchRequestData)
        let locationList = try JSONDecoder().decode([Location].self, from: data)
        return locationList
    }
}
