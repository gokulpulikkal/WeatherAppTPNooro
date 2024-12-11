//
//  RequestDataMock.swift
//  WeatherAppTPNooroTests
//
//  Created by Gokul P on 12/10/24.
//

import Foundation
@testable import WeatherAppTPNooro

enum RequestDataMock: RequestDataProtocol {

    case mock_one
    case mock_two

    var method: WeatherAppTPNooro.RequestMethod {
        switch self {
        case .mock_one:
            .get
        case .mock_two:
            .get
        }
    }

    var host: String {
        switch self {
        case .mock_one:
            "www.apple.com"
        case .mock_two:
            "www.apple.com"
        }
    }

    var endPoint: String {
        switch self {
        case .mock_one:
            "/newsroom/rss-feed.rss"
        case .mock_two:
            "/newsroom/rss-feed/two.rss"
        }
    }

    var isAuthRequired: Bool {
        switch self {
        case .mock_one:
            false
        case .mock_two:
            false
        }
    }

    var params: [String: Any]? {
        switch self {
        case .mock_one,
             .mock_two:
            nil
        }
    }

}
