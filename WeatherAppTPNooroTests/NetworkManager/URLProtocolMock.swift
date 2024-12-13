//
//  URLProtocolMock.swift
//  WeatherAppTPNooroTests
//
//  Created by Gokul P on 12/10/24.
//

import Foundation
@testable import WeatherAppTPNooro

class URLProtocolMock: URLProtocol {

    static var mockResponses: [URL: (data: Data?, response: URLResponse?, error: Error?)] = [:]
    static let lock = NSLock()

    /// say we want to handle all types of request
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    /// ignore this method; just send back what we were given
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        if let url = request.url, let mockResponse = URLProtocolMock.mockResponses[url] {
            URLProtocolMock.lock.lock()
            defer { URLProtocolMock.lock.unlock() }

            if let error = mockResponse.error {
                client?.urlProtocol(self, didFailWithError: error)
            } else {
                if let response = mockResponse.response {
                    client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                } else {
                    client?.urlProtocol(self, didReceive: HTTPURLResponse(), cacheStoragePolicy: .notAllowed)
                }
                if let data = mockResponse.data {
                    client?.urlProtocol(self, didLoad: data)
                }
                
            }
        } else {
            client?.urlProtocol(self, didFailWithError: RequestError.noResponse)
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    /// this method is required but doesn't need to do anything
    override func stopLoading() {}

    class func addMockResponse(for url: URL, data: Data?, response: URLResponse?, error: Error?) {
        lock.lock()
        defer { lock.unlock() }
        mockResponses[url] = (data, response, error)
    }

    class func clearMockResponses() {
        lock.lock()
        defer { lock.unlock() }
        mockResponses.removeAll()
    }
}
