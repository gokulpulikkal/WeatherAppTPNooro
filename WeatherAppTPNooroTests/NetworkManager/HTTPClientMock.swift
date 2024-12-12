//
//  HTTPClientMock.swift
//  WeatherAppTPNooroTests
//
//  Created by Gokul P on 12/11/24.
//

import Foundation
@testable import WeatherAppTPNooro

class HTTPClientMock: HTTPClientProtocolMock {

    var handler: (() -> Data)?

    func setImplementation(handler: @escaping () -> Data) {
        self.handler = handler
    }

    func httpData(from requestData: any WeatherAppTPNooro.RequestDataProtocol) async throws -> Data {
        if let handler {
            return handler()
        } else {
            throw RequestError.noResponse
        }
    }

}
