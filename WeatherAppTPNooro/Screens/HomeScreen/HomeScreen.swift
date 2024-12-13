//
//  HomeScreen.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/10/24.
//

import SwiftUI

struct HomeScreen: View {

    @AppStorage("selectedCityCords")
    var selectedCityCords = ""
    var viewModel = ViewModel()

    var body: some View {
        ZStack {
            noCitySelectedView
                .opacity(selectedCityCords.isEmpty ? 1 : 0)
            Group {
                switch viewModel.loadState {
                case .loading:
                    ProgressView()
                case let .success(currentWeather):
                    VStack(spacing: 36) {
                        HomeWeatherHighlightView(currentWeather: currentWeather)
                        HomeWeatherFooterView(currentWeather: currentWeather)
                    }
                case .failure:
                    errorMessageView
                }
            }
            .opacity(selectedCityCords.isEmpty ? 0 : 1)
            SearchScreenView()
        }
        .ignoresSafeArea(.keyboard)
        .onChange(of: selectedCityCords) {
            Task {
                await viewModel.getCurrentWeather(for: selectedCityCords)
            }
        }
        .task {
            await viewModel.getCurrentWeather(for: selectedCityCords)
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
