//
//  HomeWeatherFooterView.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/11/24.
//

import SwiftUI

struct HomeWeatherFooterView: View {
    
    @State var currentWeather: CurrentWeather
    
    var body: some View {
        HStack(spacing: 56) {
            VStack(spacing: 8) {
                Text("Humidity")
                    .font(.system(size: 12))
                    .foregroundStyle(.gray.secondary)
                Text("20%")
                    .font(.system(size: 15))
                    .foregroundStyle(.gray)
            }
            
            VStack(spacing: 8) {
                Text("UV")
                    .font(.system(size: 12))
                    .foregroundStyle(.gray.secondary)
                Text("4")
                    .font(.system(size: 15))
                    .foregroundStyle(.gray)
            }
            
            VStack(spacing: 8) {
                Text("Feels like")
                    .font(.system(size: 8))
                    .foregroundStyle(.gray.secondary)
                Text("38°")
                    .font(.system(size: 15))
                    .foregroundStyle(.gray)
            }
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.gray.tertiary.opacity(0.5)))
    }
}

#Preview {
    HomeWeatherFooterView(currentWeather: CurrentWeatherMock.sampleBuffaloWeather)
}
