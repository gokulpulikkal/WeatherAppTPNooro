//
//  HTTPClientProtocolMock.swift
//  WeatherAppTPNooroTests
//
//  Created by Gokul P on 12/13/24.
//

import Foundation
@testable import WeatherAppTPNooro

protocol HTTPClientProtocolMock: HTTPClientProtocol {

    func setImplementation(handler: @escaping () -> Data)
}
