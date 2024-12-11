//
//  CurrentWeatherMockData.swift
//  WeatherAppTPNooroTests
//
//  Created by Gokul P on 12/11/24.
//

import Foundation
@testable import WeatherAppTPNooro

enum CurrentWeatherMockData {
    private static let sampleBuffaloJSON = """
    {
        "location": {
            "name": "Buffalo",
            "region": "New York",
            "country": "United States of America",
            "lat": 42.8864,
            "lon": -78.8786
        },
        "current": {
            "last_updated_epoch": 1733898600,
            "last_updated": "2024-12-11 01:30",
            "temp_c": 6.7,
            "temp_f": 44.1,
            "is_day": 0,
            "condition": {
                "text": "Mist",
                "icon": "//cdn.weatherapi.com/weather/64x64/night/143.png",
                "code": 1030
            },
            "wind_mph": 2.2,
            "wind_kph": 3.6,
            "wind_degree": 312,
            "wind_dir": "NW",
            "pressure_mb": 1007.0,
            "pressure_in": 29.73,
            "precip_mm": 0.0,
            "precip_in": 0.0,
            "humidity": 96,
            "cloud": 100,
            "feelslike_c": 6.6,
            "feelslike_f": 43.9,
            "windchill_c": 5.0,
            "windchill_f": 41.0,
            "heatindex_c": 5.8,
            "heatindex_f": 42.4,
            "dewpoint_c": 5.6,
            "dewpoint_f": 42.1,
            "vis_km": 9.7,
            "vis_miles": 6.0,
            "uv": 0.0,
            "gust_mph": 3.1,
            "gust_kph": 4.9
        }
    }
    """

    private static let erroneousString = """
    {
    }
    """

    static var sampleBuffaloWeatherData: Data {
        Data(sampleBuffaloJSON.utf8)
    }

    static var sampleBuffaloWeather: CurrentWeather {
        let data = sampleBuffaloWeatherData
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(CurrentWeather.self, from: data)
        } catch {
            fatalError("Failed to decode sampleBuffaloJSON: \(error)")
        }
    }

    static var sampleErrorData: Data {
        Data(erroneousString.utf8)
    }
}
