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

    func getRequest(requestData: RequestDataProtocol) throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = requestData.scheme
        urlComponents.host = requestData.host
        urlComponents.path = requestData.apiVersion+requestData.endPoint

        if let queryParams = requestData.queryParams {
            var queryItems: [URLQueryItem] = urlComponents.queryItems ?? []
            queryParams.keys.forEach { key in
                if let value = queryParams[key] as? String {
                    let queryItem = URLQueryItem(name: key, value: value)
                    queryItems.append(queryItem)
                }
            }
            urlComponents.queryItems = queryItems
        }

        // Ensure that the URL can be constructed
        guard let url = urlComponents.url else {
            throw RequestError.decode
        }

        // Create a URLRequest using the constructed URL and the HTTP method and headers from the requestType
        var request = URLRequest(url: url)
        request.httpMethod = requestData.method.rawValue
        request.allHTTPHeaderFields = requestData.header
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let body = requestData.params {
            let serializedBody = try JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = serializedBody
        }

        return request
    }
}
