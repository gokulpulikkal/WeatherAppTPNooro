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
            "name": "London",
            "region": "City of London, Greater London",
            "country": "United Kingdom",
            "lat": 51.52,
            "lon": -0.11,
            "url": "london-city-of-london-greater-london-united-kingdom"
        },
        {
            "id": 279381,
            "name": "Londrina",
            "region": "Parana",
            "country": "Brazil",
            "lat": -23.3,
            "lon": -51.15,
            "url": "londrina-parana-brazil"
        },
        {
            "id": 315398,
            "name": "London",
            "region": "Ontario",
            "country": "Canada",
            "lat": 42.98,
            "lon": -81.25,
            "url": "london-ontario-canada"
        },
        {
            "id": 2610925,
            "name": "Londonderry",
            "region": "New Hampshire",
            "country": "United States of America",
            "lat": 42.87,
            "lon": -71.37,
            "url": "londonderry-new-hampshire-united-states-of-america"
        },
        {
            "id": 201109,
            "name": "Londerzeel",
            "region": "",
            "country": "Belgium",
            "lat": 51.0,
            "lon": 4.3,
            "url": "londerzeel-belgium"
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
