//
//  LocationSearchRequestData.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/12/24.
//

import Foundation

enum LocationSearchRequestData: RequestDataProtocol {
    case searchForLocation(keyWord: String)

    var method: RequestMethod {
        switch self {
        case .searchForLocation:
            .get
        }
    }

    var endPoint: String {
        switch self {
        case .searchForLocation:
            "/search.json"
        }
    }

    var isAuthRequired: Bool {
        switch self {
        case .searchForLocation:
            false
        }
    }

    var params: [String: Any]? {
        switch self {
        case .searchForLocation:
            nil
        }
    }

    var queryParams: [String: Any]? {
        switch self {
        case let .searchForLocation(keyWord):
            [
                "key": APIConstant.apiKey,
                "q": keyWord
            ]
        }
    }
}
