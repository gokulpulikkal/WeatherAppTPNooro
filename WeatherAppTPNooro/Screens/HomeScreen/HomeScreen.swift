//
//  HomeScreen.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/10/24.
//

import SwiftUI

struct HomeScreen: View {

    // MARK: Properties

    /// Environment object that is observed to know the network changes
    @Environment(NetworkMonitor.self) private var networkMonitor

    /// variable that retrieves the persisting city id from previous session
    @AppStorage("selectedCityId")
    var selectedCityId: Int = -1

    /// Manages the state and logic for this view.
    var viewModel = ViewModel()

    // MARK: Body

    var body: some View {
        ZStack {
            noCitySelectedView
                .opacity(selectedCityId < 0 ? 1 : 0)
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
            .opacity(selectedCityId < 0 ? 0 : 1)
            SearchScreenView()
            NoNetworkScreen(isNetworkConnected: networkMonitor.isConnected)
                .opacity(networkMonitor.isConnected ? 0 : 1)
        }
        .ignoresSafeArea(.keyboard)
        .onChange(of: selectedCityId) {
            Task {
                await viewModel.getCurrentWeather(for: selectedCityId)
            }
        }
        .task {
            await viewModel.getCurrentWeather(for: selectedCityId)
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
        .environment(NetworkMonitor())
}
