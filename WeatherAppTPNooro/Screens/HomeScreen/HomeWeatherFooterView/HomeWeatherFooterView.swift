//
//  HomeWeatherFooterView.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/11/24.
//

import SwiftUI

/// A view that shows the a collection of details regarding the current weather
struct HomeWeatherFooterView: View {

    /// The currentWeather object that act as data source for this view
    var currentWeather: CurrentWeather

    // MARK: Body

    var body: some View {
        HStack(spacing: 56) {
            humidityView
            uvIndexView
            feelsLikeView
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.boxBackground))
        .frame(width: 274)
    }
}

extension HomeWeatherFooterView {
    // MARK: Subviews

    /// A view that shows the humidity of the current weather
    var humidityView: some View {
        VStack(spacing: 8) {
            Text("Humidity")
                .font(.system(size: 12))
                .foregroundStyle(.textColorTertiary)
            Text((currentWeather.current?.humidity ?? 0) / 100, format: .percent)
                .font(.system(size: 15))
                .foregroundStyle(.textColorSecondary)
        }
    }

    /// A view that shows the UV index of the current weather
    var uvIndexView: some View {
        VStack(spacing: 8) {
            Text("UV")
                .font(.system(size: 12))
                .foregroundStyle(.textColorTertiary)
            Text(currentWeather.current?.uvIndex ?? 0, format: .number)
                .font(.system(size: 15))
                .foregroundStyle(.textColorSecondary)
        }
    }

    /// A view that shows the feels like temperature of the current weather
    var feelsLikeView: some View {
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
}

#Preview {
    HomeWeatherFooterView(currentWeather: CurrentWeatherMock.sampleBuffaloWeather)
}
