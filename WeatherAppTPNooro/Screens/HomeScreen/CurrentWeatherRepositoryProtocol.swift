//
//  CurrentWeatherRepositoryProtocol.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/11/24.
//

import Foundation

protocol CurrentWeatherRepositoryProtocol {

    func currentWeather(cityName: String) async throws -> CurrentWeather

}
