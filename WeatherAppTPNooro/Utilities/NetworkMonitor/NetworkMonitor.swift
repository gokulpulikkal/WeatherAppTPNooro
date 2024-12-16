//
//  NetworkMonitor.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/15/24.
//

import Foundation
import Network
import Observation

/// A class that can be observed for network changes
/// Observe the flag `isConnected` to know the network changes
@Observable
class NetworkMonitor {

    /// network monitor class
    let networkPathMonitor = NWPathMonitor()

    /// flag to know weather the network is connected or not
    /// This flag should be updated in the main thread since it will be directly used by
    /// views to update their status
    @MainActor
    var isConnected = false

    init() {
        startNetworkMonitoring()
    }

    deinit {
        stopNetworkMonitoring()
    }

    /// Function to start the monitoring of the network
    /// It'll update the `isConnected` flag in the main thread
    func startNetworkMonitoring() {
        let queue = DispatchQueue(label: "NetworkMonitoring")
        networkPathMonitor.pathUpdateHandler = { [weak self] path in
            Task { @MainActor in
                self?.isConnected = path.status == .satisfied
            }
        }
        networkPathMonitor.start(queue: queue)
    }

    /// Stops the network monitoring
    func stopNetworkMonitoring() {
        networkPathMonitor.cancel()
    }
}
