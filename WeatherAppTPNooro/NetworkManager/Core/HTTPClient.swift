//
//  HTTPClient.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/10/24.
//

import Foundation

// MARK: - URLSession + HTTPClientProtocol

/// The client that can be used for API calls and any network related calls
class HTTPClient: HTTPClientProtocol {
    // MARK: Properties

    /// URL session to be used for the API call
    var session: URLSession

    // MARK: Initializer

    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    // MARK: Functions

    /// function that makes the URL request from request data and then makes the API call and returns the Data
    func httpData(from requestData: RequestDataProtocol) async throws -> Data {
        let request = try getRequest(requestData: requestData)

        guard let (data, response) = try await session.data(for: request) as? (Data, HTTPURLResponse) else {
            throw RequestError.unexpectedStatusCode
        }
        switch response.statusCode {
        case 200...299:
            return data
        default:
            throw RequestError.unexpectedStatusCode
        }
    }
}
