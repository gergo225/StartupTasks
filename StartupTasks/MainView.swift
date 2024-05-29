//
//  ContentView.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 25.05.2024.
//

import SwiftUI
import LaunchAtLogin

struct MainView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text(openSettingsToChangeText)
        }
        .padding()
    }

    private let openSettingsToChangeText: String = "Open settings to change this option"
}

#Preview {
    MainView()
}
