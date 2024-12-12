//
//  HomeWeatherFooterView.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/11/24.
//

import SwiftUI

struct HomeWeatherFooterView: View {

    var currentWeather: CurrentWeather

    var body: some View {
        HStack(spacing: 56) {
            VStack(spacing: 8) {
                Text("Humidity")
                    .font(.system(size: 12))
                    .foregroundStyle(.textColorTertiary)
                Text((currentWeather.current?.humidity ?? 0) / 100, format: .percent)
                    .font(.system(size: 15))
                    .foregroundStyle(.textColorSecondary)
            }

            VStack(spacing: 8) {
                Text("UV")
                    .font(.system(size: 12))
                    .foregroundStyle(.textColorTertiary)
                Text(currentWeather.current?.uvIndex ?? 0, format: .number)
                    .font(.system(size: 15))
                    .foregroundStyle(.textColorSecondary)
            }

            VStack(spacing: 8) {
                Text("Feels like")
                    .font(.system(size: 8))
                    .foregroundStyle(.textColorTertiary)
                HStack(spacing: 0) {
                    Text(currentWeather.current?.feelsLikeCelsius ?? 0, format: .number.precision(.fractionLength(2)))
                    Text("°")
                }
                .font(.system(size: 15))
                .foregroundStyle(.textColorSecondary)
            }
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.boxBackground))
    }
}

#Preview {
    HomeWeatherFooterView(currentWeather: CurrentWeatherMock.sampleBuffaloWeather)
}
