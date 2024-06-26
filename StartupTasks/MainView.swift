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
        MainViewContent(model: viewModel.model, onAction: viewModel.onAction)
    }
}

struct MainViewContent: View {
    @ObservedObject var model: MainModel
    var onAction: (MainAction) -> Void = { _ in }

    @State private var launchedAtLogin: Bool? = nil
    @State private var selectedProfile: Profile?

    var body: some View {
        NavigationSplitView {
            VStack(alignment: .leading) {
                List(model.profiles, id: \.id, selection: $selectedProfile) { profile in
                    NavigationLink(value: profile, label: {
                        Label(profile.name, systemImage: "folder")
                    })
                    .contextMenu {
                        Button("Delete") {
                            onAction(.removeProfile(profile: profile))
                        }
                    }
                }

                addNewProfileButton
            }
        } detail: {
            if let selectedProfile {
                ProfileRouter.profilePage(for: selectedProfile)
            } else {
                Text("No profile selected")
            }
        }
        .navigationTitle(selectedProfile?.name ?? "")
        .frame(minWidth: 600, minHeight: 400, maxHeight: .infinity)
        .onAppear {
            if selectedProfile == nil {
                selectedProfile = model.profiles.first
            }
            launchedAtLogin = LoginDefaults.standard.launchedAtLogin
        }
        .onChange(of: launchedAtLogin) {
            guard let launchedAtLogin else { return }
            onAction(.launchedAtLoginChanged(launchedAtLogin: launchedAtLogin))
        }
    }

    private var addNewProfileButton: some View {
        Button {
            onAction(.addProfilePressed)
        } label: {
            Label("New", systemImage: "plus")
                .foregroundStyle(.secondary)
                .padding([.vertical, .leading])
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(.buttonBorder)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    let safariPath = URL(string: "/Applications/Safari.app")!
    let weatherPath = URL(string: "/System/Applications/Weather.app")!
    let appPaths = [safariPath, weatherPath]

    let urls = [
        URL(string: "https://typeracer.com")!,
        URL(string: "https://youtube.com")!,
        URL(string: "https://facebook.com")!
    ]

    let profile = Profile(name: "Live Coding", apps: appPaths, urls: urls)
    let profileViewModel = ProfileViewModel(profile: profile)

    let model = MainModel()
    model.profiles = [profile]
    let viewModel = MainViewModel()
    viewModel.model = model

    return MainView(viewModel: viewModel)
}
