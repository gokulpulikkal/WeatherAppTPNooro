//
//  SearchLocationRepositoryProtocol.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/12/24.
//

/// A protocol for types that manage the retrieval locations that matches the keyword
protocol SearchLocationRepositoryProtocol {

    /// function that returns the list of locations for the param `keyWord`
    func getLocations(for keyWord: String) async throws -> [Location]
}
