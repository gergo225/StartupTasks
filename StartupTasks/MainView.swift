//
//  ContentView.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 25.05.2024.
//

import SwiftUI
import LaunchAtLogin

struct MainView: View {
    @State private var launchedAtLogin: Bool? = nil

    var body: some View {
        VStack(spacing: 16) {
            Text(Strings.openSettingsToChange)

            Text(launchSourceText)
        }
        .padding()
        .onAppear {
            launchedAtLogin = LoginDefaults.standard.launchedAtLogin
        }
    }

    private var launchSourceText: String {
        guard let launchedAtLogin else {
            return Strings.emptyValue
        }

        return launchedAtLogin ? Strings.launcedAtLogin : Strings.launcedByUser
    }
}

#Preview {
    MainView()
}
