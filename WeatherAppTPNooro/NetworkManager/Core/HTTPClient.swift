//
//  HTTPClient.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/10/24.
//

import Foundation

// MARK: - URLSession + HTTPClientProtocol

class HTTPClient: HTTPClientProtocol {

    var session: URLSession

    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

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
