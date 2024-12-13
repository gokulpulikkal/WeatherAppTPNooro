//
//  LocationsMockData.swift
//  WeatherAppTPNooroTests
//
//  Created by Gokul P on 12/12/24.
//

import Foundation
@testable import WeatherAppTPNooro

enum LocationsMockData {
    private static let sampleCitiesJSON = """
    [
        {
            "id": 2801268,
            "name": "Buffalo",
            "region": "New York",
            "country": "United States of America",
            "lat": 42.8864,
            "lon": -78.8786
        }
    ]
    """

    private static let erroneousString = """
    {
    }
    """

    static var sampleCitiesData: Data {
        Data(sampleCitiesJSON.utf8)
    }

    static var sampleCities: [Location] {
        let data = sampleCitiesData
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([Location].self, from: data)
        } catch {
            fatalError("Failed to decode sampleCitiesJSON: \(error)")
        }
    }

    static var sampleErrorData: Data {
        Data(erroneousString.utf8)
    }
}
