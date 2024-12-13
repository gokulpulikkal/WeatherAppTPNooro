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

    // MARK: Body

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
        .animation(.bouncy, value: viewModel.loadState)
    }

}

extension HomeScreen {
    // MARK: Subviews

    /// A view that shows no city selected prompting the user to search for a view
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

    /// A view show an error for displaying error info to the user in case the wether response for the
    /// selected city is not available for some reason from the API
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
