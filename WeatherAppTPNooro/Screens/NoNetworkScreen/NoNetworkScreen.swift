//
//  NoNetworkScreen.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/16/24.
//

import SwiftUI

/// A view that will show the no network screen
struct NoNetworkScreen: View {

    // MARK: Properties

    /// boolean variable to set the network status
    var isNetworkConnected: Bool

    // MARK: Body

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.backgroundColorPrimary)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Image(systemName: isNetworkConnected ? "wifi" : "wifi.slash")
                    .font(.title)
                    .foregroundStyle(isNetworkConnected ? .green : .red)

                Text(isNetworkConnected ? "Connected" : "Disconnected")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(isNetworkConnected ? .green : .red)
            }
        }
    }
}

#Preview {
    NoNetworkScreen(isNetworkConnected: true)
}
