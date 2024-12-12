//
//  SearchLocationRepositoryMock.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/12/24.
//

import Foundation
@testable import WeatherAppTPNooro

class SearchLocationRepositoryMock: SearchLocationRepositoryProtocolMock {

    var mockLocationsResponseMap: [String: [WeatherAppTPNooro.Location]] = [:]

    func setLocationsResponse(keyWord: String, locations: [WeatherAppTPNooro.Location]) {
        mockLocationsResponseMap[keyWord] = locations
    }

    func getLocations(for keyWord: String) async throws -> [WeatherAppTPNooro.Location] {
        if mockLocationsResponseMap[keyWord] != nil {
            return mockLocationsResponseMap[keyWord]!
        } else {
            throw RequestError.unknown
        }
    }

}
