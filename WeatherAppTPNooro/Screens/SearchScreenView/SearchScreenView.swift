//
//  SearchScreenView.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/11/24.
//

import SwiftUI

/// A view that shows the search bar and the search results
struct SearchScreenView: View {
    // MARK: Properties

    /// Manages the state and logic for this view.
    @State var viewModel = ViewModel()

    /// A variable that holds value weather the search text field is in focus or not
    @FocusState var isSearchFieldFocused: Bool

    /// variable that saves the selected city's coordinates string to apps persistent storage
    @AppStorage("selectedCityCords")
    var selectedCityCords = ""

    // MARK: Body

    var body: some View {
        ZStack {
            backgroundView
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
                        List(
                            viewModel.currentWeatherList,
                            id: \.self,
                            selection: $viewModel.selectedWeatherLocation,
                            rowContent: { currentWeather in
                                getLocationListRow(currentWeather: currentWeather)
                                    .listRowSeparator(.hidden)
                                    .listRowBackground(Color.clear)
                            }
                        )
                        .listStyle(.plain)
                    case .failure:
                        errorMessageView
                    }
                }
                .padding(5)
                .opacity(isSearchFieldFocused || !viewModel.currentWeatherList.isEmpty ? 1 : 0)
            }
        }
        .onChange(of: viewModel.searchKey) {
            if viewModel.searchKey.isEmpty {
                viewModel.clearSearchResults()
            } else {
                Task {
                    await viewModel.locations(for: viewModel.searchKey)
                }
            }
        }
        .onChange(of: viewModel.selectedWeatherLocation) {
            if let selectedWeatherLocation = viewModel.selectedWeatherLocation {
                selectedCityCords = "\(selectedWeatherLocation.location.lat),\(selectedWeatherLocation.location.lon)"
                dismissSearchResultView()
            }
        }
        .animation(.bouncy, value: viewModel.currentWeatherList)
        .animation(.bouncy, value: isSearchFieldFocused)
    }
}

extension SearchScreenView {
    // MARK: Subviews

    /// A view for getting input from the user for the city search
    var searchTextFieldView: some View {
        HStack {
            TextField(text: $viewModel.searchKey, label: {
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

    /// A view that will act as background covering full screen when the search is in progress or search bar gets focus
    var backgroundView: some View {
        Rectangle()
            .foregroundStyle(.backgroundColorPrimary)
            .opacity(isSearchFieldFocused || !viewModel.currentWeatherList.isEmpty ? 1 : 0)
    }

    /// A view that will show the error view when search API returns empty results or in case of API errors
    var errorMessageView: some View {
        VStack {
            Spacer()
            Image(systemName: "exclamationmark.circle")
                .resizable()
                .frame(width: 50, height: 50)
            Text("The searched city is not found")
                .font(.system(size: 20))
                .bold()
            Spacer()
        }
    }

    /// A view that will show the search result city name and it's weather details
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

    // MARK: Functions

    /// A function to dismiss the full screen search view.
    /// the view should show only search bar once this function is called
    func dismissSearchResultView() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
        viewModel.clearSearchResults()
    }
}

#Preview {
    SearchScreenView()
}
