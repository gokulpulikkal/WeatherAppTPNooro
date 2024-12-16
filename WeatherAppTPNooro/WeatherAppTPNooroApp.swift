//
//  WeatherAppTPNooroApp.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/10/24.
//

import SwiftUI

@main
struct WeatherAppTPNooroApp: App {
    @State private var networkMonitor = NetworkMonitor()

    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environment(networkMonitor)
        }
    }
}
