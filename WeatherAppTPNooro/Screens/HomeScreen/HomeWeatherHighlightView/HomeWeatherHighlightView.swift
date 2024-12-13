//
//  HomeWeatherHighlightView.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/11/24.
//

import SwiftUI

struct HomeWeatherHighlightView: View {

    var currentWeather: CurrentWeather

    var body: some View {
        VStack(spacing: 16) {
            
            AsyncImage(url: URL(string: "https:" + (currentWeather.current?.condition.icon.replacingOccurrences(of: "64x64", with: "128x128") ?? ""))) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 123, height: 123)
            HStack {
                Text(currentWeather.location.name)
                    .foregroundStyle(.textColorPrimary)
                    .font(.system(size: 30))
                    .bold()
                Image(systemName: "location.fill")
                    .resizable()
                    .frame(width: 21, height: 21)
            }
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
}

#Preview {
    HomeWeatherHighlightView(currentWeather: CurrentWeatherMock.sampleBuffaloWeather)
}
