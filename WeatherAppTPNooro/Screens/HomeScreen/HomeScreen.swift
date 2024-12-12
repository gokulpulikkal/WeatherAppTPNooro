//
//  HomeScreen.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/10/24.
//

import SwiftUI

struct HomeScreen: View {

    @AppStorage("selectedCity")
    var selectedCity = "Hyderabad"
    var viewModel = ViewModel()

    var body: some View {
        if selectedCity.isEmpty {
            noCitySelectedView
        } else {
            Group {
                switch viewModel.loadState {
                case .loading:
                    ProgressView()
                case let .success(currentWeather):
                    ZStack {
                        VStack(spacing: 36) {
                            HomeWeatherHighlightView(currentWeather: currentWeather)
                            HomeWeatherFooterView(currentWeather: currentWeather)
                        }
                        SearchScreenView()
                    }
                case .failure:
                    errorMessageView
                }
            }
            .task {
                await viewModel.getCurrentWeather(for: selectedCity)
            }
        }
    }
}

extension HomeScreen {
    var noCitySelectedView: some View {
        VStack(spacing: 20) {
            Text("No City Selected")
                .font(.system(size: 30))
                .bold()
            Text("Please Search For A City")
                .font(.system(size: 15))
                .bold()
        }
    }

    var errorMessageView: some View {
        VStack {
            Image(systemName: "exclamationmark.circle")
                .resizable()
                .frame(width: 50, height: 50)
            Text("Oh Something went wrong")
                .font(.system(size: 20))
                .bold()
        }
    }
}

#Preview {
    HomeScreen()
}
