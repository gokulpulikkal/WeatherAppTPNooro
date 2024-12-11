//
//  CurrentWeatherRequestData.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/11/24.
//

import Foundation

enum WeatherRequestData: RequestDataProtocol {

    case currentWeather(location: String)

    var method: RequestMethod {
        switch self {
        case .currentWeather:
            .get
        }
    }

    var endPoint: String {
        switch self {
        case .currentWeather:
            "/current.json"
        }
    }

    var isAuthRequired: Bool {
        switch self {
        case .currentWeather:
            false
        }
    }

    var params: [String: Any]? {
        switch self {
        case .currentWeather:
            nil
        }
    }

    var queryParams: [String: Any]? {
        switch self {
        case let .currentWeather(location):
            [
                "key": APIConstant.apiKey,
                "q": location
            ]
        }
    }

}