//
//  SearchLocationRepositoryProtocolMock.swift
//  WeatherAppTPNooroTests
//
//  Created by Gokul P on 12/12/24.
//

import Foundation
@testable import WeatherAppTPNooro

protocol SearchLocationRepositoryProtocolMock: SearchLocationRepositoryProtocol {

    func setLocationsResponse(keyWord: String, locations: [Location])
}
