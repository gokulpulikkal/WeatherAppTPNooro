//
//  RequestError.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/10/24.
//

import Foundation

/// Enum to represent different types of errors that can occur during a network request.
enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorised
    case unexpectedStatusCode
    case unknown
    case invalidRequest

    var customMessage: String {
        switch self {
        case .decode:
            "Decode error"
        case .unauthorised:
            "Session expired"
        case .invalidURL:
            "Error in creating the request object"
        default:
            "Unknown error"
        }
    }
}
