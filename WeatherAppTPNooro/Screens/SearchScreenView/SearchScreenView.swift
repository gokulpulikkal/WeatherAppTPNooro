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
    @AppStorage("selectedCityCords")
    var selectedCityCords = ""
    @State var selectedWeatherLocation: CurrentWeather? = nil

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.backgroundColorPrimary)
                .opacity(isSearchFieldFocused || !viewModel.currentWeatherList.isEmpty ? 1 : 0)
            VStack {
                searchTextFieldView
                    .padding(.top, 24)
                    .padding(.horizontal, 24)
                Spacer()
                VStack {
                    switch viewModel.loadState {
                    case .loading:
                        ProgressView()
                            .opacity(viewModel.isSearchInProgress ? 1 : 0)
                    case .success:
                        List(selection: $selectedWeatherLocation) {
                            ForEach(viewModel.currentWeatherList) { currentWeather in
                                getLocationListRow(currentWeather: currentWeather)
                                    .tag(currentWeather)
                                    .listRowSeparator(.hidden)
                                    .listRowBackground(Color.clear)
                            }
                        }
                        .listStyle(.plain)
                    case .failure:
                        Text("Error in searching for location!")
                    }
                }
                .padding(5)
                .opacity(isSearchFieldFocused || !viewModel.currentWeatherList.isEmpty ? 1 : 0)
            }
        }
        .onChange(of: searchKey) {
            if searchKey.isEmpty {
                viewModel.clearSearchResults()
            } else {
                Task {
                    await viewModel.locations(for: searchKey)
                }
            }
        }
        .onChange(of: selectedWeatherLocation) {
            if let selectedWeatherLocation {
                selectedCityCords = "\(selectedWeatherLocation.location.lat),\(selectedWeatherLocation.location.lon)"
                dismissSearchResultView()
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
                    dismissSearchResultView()
                }
            }
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.boxBackground))
    }

    func getLocationListRow(currentWeather: CurrentWeather) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(currentWeather.location.name)
                    .lineLimit(1)
                    .font(.system(size: 20))
                    .bold()
                if let weatherDetails = currentWeather.current {
                    HStack {
                        Text(String(Int(weatherDetails.temperatureCelsius)))
                            .foregroundStyle(.textColorPrimary)
                            .font(.system(size: 60))
                            .fontWeight(.semibold)
                        VStack {
                            Text("°")
                                .font(.system(size: 20))
                                .fontWeight(.thin)
                                .foregroundStyle(.textColorPrimary)
                            Spacer()
                        }
                        .frame(height: 55)
                    }
                }
            }
            Spacer()
            AsyncImage(url: URL(
                string: "https:" +
                    (currentWeather.current?.condition.icon ?? "")
            )) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 83, height: 83)
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.boxBackground))
    }

    func dismissSearchResultView() {
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

#Preview {
    SearchScreenView()
}
