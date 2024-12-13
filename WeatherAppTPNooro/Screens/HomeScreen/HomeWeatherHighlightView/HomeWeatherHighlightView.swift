//
//  HomeWeatherHighlightView.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/11/24.
//

import SwiftUI

/// A view that displays the main weather details
struct HomeWeatherHighlightView: View {
    // MARK: Properties

    /// The currentWeather object that act as data source for this view
    var currentWeather: CurrentWeather

    // MARK: Body

    var body: some View {
        VStack(spacing: 16) {
            weatherConditionIcon
            locationNameView
            temperatureDigitView
        }
    }
}

extension HomeWeatherHighlightView {
    // MARK: Subviews

    /// A view that shows the current weather condition image
    var weatherConditionIcon: some View {
        AsyncImage(url: URL(
            string: "https:" +
                (
                    currentWeather.current?.condition.icon
                        .replacingOccurrences(of: "64x64", with: "128x128") ?? ""
                )
        )) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 123, height: 123)
    }

    /// A view that shows the location details for which the weather data is being shown
    var locationNameView: some View {
        HStack {
            Text(currentWeather.location.name)
                .foregroundStyle(.textColorPrimary)
                .font(.system(size: 30))
                .bold()
            Image(systemName: "location.fill")
                .resizable()
                .frame(width: 21, height: 21)
        }
    }

    /// A view that shows the temperature in celsius
    var temperatureDigitView: some View {
        HStack {
            Text(String(Int(currentWeather.current?.temperatureCelsius ?? 0)))
                .foregroundStyle(.textColorPrimary)
                .font(.system(size: 70))
                .fontWeight(.semibold)
            VStack {
                Text("°")
                    .font(.system(size: 40))
                    .fontWeight(.thin)
                    .foregroundStyle(.textColorPrimary)
                Spacer()
            }
            .frame(height: 85)
        }
    }
}

#Preview {
    HomeWeatherHighlightView(currentWeather: CurrentWeatherMock.sampleBuffaloWeather)
}
