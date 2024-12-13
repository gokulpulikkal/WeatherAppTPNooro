//
//  RequestError.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/10/24.
//

import Foundation

/// A value to represent different types of errors that can occur during a network request.
enum RequestError: Error {
    /// error when JSON decoding fails
    case decode

    /// The URL provided is invalid
    case invalidURL
    
    /// no response is returned
    case noResponse
    
    /// unauthorised access to the end point
    case unauthorised
    
    /// unexpectedStatusCode returned from the end point
    case unexpectedStatusCode
    
    /// some unknown error
    case unknown
    
    /// the request is invalid. Due to some bad request parameter value
    case invalidRequest

    /// message for the error
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
