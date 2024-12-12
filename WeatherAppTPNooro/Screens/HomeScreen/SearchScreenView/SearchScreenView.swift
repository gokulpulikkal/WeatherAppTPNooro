//
//  SearchScreenView.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/11/24.
//

import SwiftUI

struct SearchScreenView: View {

    @State var searchKey = ""
    @FocusState var isSearchFieldFocused: Bool
    @State var showSearchListing = false

    var body: some View {
        VStack {
            HStack {
                TextField(text: $searchKey, label: {
                    Text("Search Location")
                        .font(.system(size: 15))
                        .foregroundStyle(.textColorTertiary)
                })
                .focused($isSearchFieldFocused)
                Image(systemName: isSearchFieldFocused ? "xmark.circle" : "magnifyingglass")
                    .resizable()
                    .frame(width: 17, height: 17)
                    .foregroundStyle(.textColorTertiary)
                    .onTapGesture {
                        if isSearchFieldFocused {
                            UIApplication.shared.sendAction(
                                #selector(UIResponder.resignFirstResponder),
                                to: nil,
                                from: nil,
                                for: nil
                            )
                        }
                    }
            }
            .padding(16)
            .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.boxBackground))
            .padding(.top, 24)
            Spacer()
        }
        .padding(.horizontal, 24)
        .onChange(of: isSearchFieldFocused) {
            print("Focus of TextField changed \(isSearchFieldFocused)")
        }
    }
}

#Preview {
    SearchScreenView()
}
