//
//  ContentView.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 25.05.2024.
//

import SwiftUI
import LaunchAtLogin

struct MainView: View {
    @StateObject var viewModel: MainViewModel = MainViewModel()

    var body: some View {
        MainViewContent(onAction: viewModel.onAction)
    }
}

struct MainViewContent: View {
    var onAction: (MainAction) -> Void = { _ in }

    @State private var launchedAtLogin: Bool? = nil

    var body: some View {
        ProfilePage()
        .onAppear {
            launchedAtLogin = LoginDefaults.standard.launchedAtLogin
        }
        .onChange(of: launchedAtLogin) {
            guard let launchedAtLogin else { return }
            onAction(.launchedAtLoginChanged(launchedAtLogin: launchedAtLogin))
        }
    }
}

#Preview {
    MainView()
}
