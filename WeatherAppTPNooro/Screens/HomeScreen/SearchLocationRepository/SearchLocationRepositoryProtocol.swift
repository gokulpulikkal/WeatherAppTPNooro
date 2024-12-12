//
//  SearchLocationRepositoryProtocol.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/12/24.
//

protocol SearchLocationRepositoryProtocol {

    func getLocations(for keyWord: String) async throws -> [Location]
}
