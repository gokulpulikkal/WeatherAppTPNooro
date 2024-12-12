//
//  SearchScreenView.swift
//  WeatherAppTPNooro
//
//  Created by Gokul P on 12/11/24.
//

import SwiftUI

struct SearchScreenView: View {
    @State var searchKey: String = ""
    var body: some View {
        TextField(text: $searchKey, label: {
            Text("Search Location")
                .font(.system(size: 15))
        })
    }
}

#Preview {
    SearchScreenView()
}
