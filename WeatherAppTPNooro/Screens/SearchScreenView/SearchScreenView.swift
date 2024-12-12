//
//  SearchScreenView.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/11/24.
//

import SwiftUI

struct SearchScreenView: View {

    @State var searchKey = ""
    @State var viewModel = ViewModel()
    @FocusState var isSearchFieldFocused: Bool

    var body: some View {
        VStack {
            searchTextFieldView
                .padding(.top, 24)
            Spacer()
            VStack {
                switch viewModel.loadState {
                case .loading:
                    ProgressView()
                        .opacity(viewModel.isSearchInProgress ? 1 : 0)
                case .success:
                    List {
                        ForEach(viewModel.currentWeatherList) { currentWeather in
                            HStack {
                                Text(currentWeather.location.name)
                                if let weatherDetails = currentWeather.current {
                                    Text("\(weatherDetails.feelsLikeCelsius)")
                                }
                            }
                        }
                    }
                case .failure:
                    Text("Error in searching for location!")
                }
            }
            .ignoresSafeArea()
            .opacity(isSearchFieldFocused || !viewModel.currentWeatherList.isEmpty ? 1 : 0)
        }
        .padding(.horizontal, 24)
        .onChange(of: searchKey) {
            Task {
                await viewModel.locations(for: searchKey)
            }
        }
    }
}

extension SearchScreenView {
    var searchTextFieldView: some View {
        HStack {
            TextField(text: $searchKey, label: {
                Text("Search Location")
                    .font(.system(size: 15))
                    .foregroundStyle(.textColorTertiary)
            })
            .focused($isSearchFieldFocused)
            Image(
                systemName: isSearchFieldFocused || !viewModel.currentWeatherList.isEmpty
                    ? "xmark.circle"
                    : "magnifyingglass"
            )
            .resizable()
            .frame(width: 17, height: 17)
            .foregroundStyle(.textColorTertiary)
            .onTapGesture {
                if isSearchFieldFocused || !viewModel.currentWeatherList.isEmpty {
                    UIApplication.shared.sendAction(
                        #selector(UIResponder.resignFirstResponder),
                        to: nil,
                        from: nil,
                        for: nil
                    )
                    viewModel.clearSearchResults()
                    searchKey = ""
                }
            }
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.boxBackground))
    }
}

#Preview {
    SearchScreenView()
}
