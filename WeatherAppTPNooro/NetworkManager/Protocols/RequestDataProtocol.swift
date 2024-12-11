//
//  RequestDataProtocol.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/10/24.
//

import Foundation

protocol RequestDataProtocol {

    /// Request method type
    var method: RequestMethod { get }

    var scheme: String { get }

    /// Request end point
    var endPoint: String { get }

    /// Get authentication required or not for the request to set the
    /// authorization header
    var isAuthRequired: Bool { get }

    /// Request params
    var params: [String: Any]? { get }

    /// API Version for the url
    var apiVersion: String { get }

    /// Header values for request
    var header: [String: String]? { get }

    var host: String { get }

    var queryParams: [String: Any]? { get }
}

/// Default values
extension RequestDataProtocol {

    var apiVersion: String {
        APIVersion.version1
    }

    var scheme: String {
        "https"
    }

    var host: String {
        APIConstant.baseURL
    }

    var header: [String: String]? {
        ["api-key": APIConstant.apiKey]
    }

    var queryParams: [String: Any]? {
        nil
    }
}
