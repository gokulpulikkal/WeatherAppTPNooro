//
//  HomeWeatherHighlightView.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/11/24.
//

import SwiftUI

struct HomeWeatherHighlightView: View {

    @State var currentWeather: CurrentWeather

    var body: some View {
        VStack(spacing: 16) {
            AsyncImage(url: URL(string: "https:" + currentWeather.current.condition.icon)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 123, height: 123)
            HStack {
                Text(currentWeather.location.name)
                    .font(.system(size: 30))
                    .bold()
                Image(systemName: "location.fill")
                    .resizable()
                    .frame(width: 21, height: 21)
            }
            HStack {
                Text(String(Int(currentWeather.current.temperatureCelsius)))
                    .font(.system(size: 70))
                    .fontWeight(.semibold)
                VStack {
                    Text("°")
                        .font(.system(size: 40))
                        .fontWeight(.thin)
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
