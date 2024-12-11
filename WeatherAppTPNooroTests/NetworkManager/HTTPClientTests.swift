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
        URLProtocolMock.clearMockResponses()
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
        URLProtocolMock.mockResponses = [:]
        // Setting up the data
        let url = URL(string: "https://www.apple.com/newsroom/rss-feed.rss")!
        let expectedData = "Hacking with Swift!".data(using: .utf8)
        URLProtocolMock.addMockResponse(for: url, data: expectedData, response: nil, error: nil)
        let mockRequest = RequestDataMock.mock_one

        // Create client
        let httpClient = HTTPClient(session: urlSession)
        let result = try await httpClient.httpData(from: mockRequest)
        #expect(result == expectedData)
        URLProtocolMock.clearMockResponses()
    }

    @Test
    func failedHTTPDataTest() async throws {
        URLProtocolMock.mockResponses = [:]
        let url = URL(string: "https://www.apple.com/newsroom/rss-feed/two.rss")!
        let expectedError = RequestError.unknown
        URLProtocolMock.addMockResponse(for: url, data: nil, response: nil, error: expectedError)
        let mockRequest = RequestDataMock.mock_two
        // Create client
        let httpClient = HTTPClient(session: urlSession)
        await #expect(performing: {
            try await httpClient.httpData(from: mockRequest)
        }, throws: { error in
            expectedError.localizedDescription == error.localizedDescription
        })
        URLProtocolMock.clearMockResponses()
    }

}
