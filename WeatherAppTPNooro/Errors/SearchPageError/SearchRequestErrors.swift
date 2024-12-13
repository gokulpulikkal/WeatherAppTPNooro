//
//  SearchRequestErrors.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/12/24.
//

import Foundation

/// A value to represent the search screen related errors
enum SearchRequestErrors: Error {

    /// No search result
    case noResultError

    /// message for the error
    var customMessage: String {
        switch self {
        case .noResultError:
            "No results found!"
        }
    }
}
