//
//  HTTPClientTests.swift
//  WeatherAppTPNooroTests
//
//  Created by Gokul P on 12/10/24.
//

import Foundation
import Testing
@testable import WeatherAppTPNooro

struct HTTPClientTests {

    var urlSession: URLSession

    init() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        self.urlSession = URLSession(configuration: config)
    }

    @Test
    func makeRequestSuccessTest() throws {
        let url = URL(string: "https://www.apple.com/newsroom/rss-feed.rss")!
        let expectedRequest = URLRequest(url: url)
        let httpClient = HTTPClient()
        let mockRequest = RequestDataMock.mock_one
        let request = try httpClient.getRequest(requestData: mockRequest)

        #expect(request.url == expectedRequest.url)
    }

    @Test
    func makeRequestFailTest() throws {
        let url = URL(string: "https://www.apple.com/newsroom/rss-feed.rss")!
        let expectedRequest = URLRequest(url: url)
        let httpClient = HTTPClient()
        let mockRequest = RequestDataMock.mock_two
        let request = try httpClient.getRequest(requestData: mockRequest)

        #expect(request.url != expectedRequest.url)
    }

    @Test
    func successfulHTTPDataTest() async throws {
        
        // Setting up the data
        let httpClient = HTTPClient(session: urlSession)
        let mockRequestData = RequestDataMock.mock_one
        let mockRequest = try httpClient.getRequest(requestData: mockRequestData)
        let expectedData = "Hacking with Swift!".data(using: .utf8)
        URLProtocolMock.addMockResponse(for: mockRequest.url!, data: expectedData, response: HTTPURLResponse(), error: nil)
        
        let result = try await httpClient.httpData(from: mockRequestData)
        #expect(result == expectedData)
    }

    @Test
    func failedHTTPDataTest() async throws {
        // Setting up the data
        let httpClient = HTTPClient(session: urlSession)
        let mockRequestData = RequestDataMock.mock_two
        let mockRequest = try httpClient.getRequest(requestData: mockRequestData)
        
        let expectedError = RequestError.unknown
        URLProtocolMock.addMockResponse(for: mockRequest.url!, data: nil, response: HTTPURLResponse(), error: expectedError)
        
        await #expect(performing: {
            try await httpClient.httpData(from: mockRequestData)
        }, throws: { error in
            expectedError.localizedDescription == error.localizedDescription
        })
    }

}
