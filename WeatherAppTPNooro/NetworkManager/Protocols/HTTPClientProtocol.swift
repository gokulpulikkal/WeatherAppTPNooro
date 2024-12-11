//
//  HTTPClientProtocol.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/10/24.
//

import Foundation

protocol HTTPClientProtocol {
    var session: URLSession { get }
    func httpData(from requestData: RequestDataProtocol) async throws -> Data
    func getRequest(requestData: RequestDataProtocol) throws -> URLRequest
}
