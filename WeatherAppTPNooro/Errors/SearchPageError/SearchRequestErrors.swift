//
//  SearchRequestErrors.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/12/24.
//

import Foundation

enum SearchRequestErrors: Error {
    case noResultError
    var customMessage: String {
        switch self {
        case .noResultError:
            "No results found!"
        default:
            "Unknown error"
        }
    }
}
