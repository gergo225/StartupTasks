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
    @State private var profileViewModel = ProfileViewModel(appsViewModel: AppsViewModel(), urlsViewModel: UrlsViewModel())

    @State private var dummyProfiles: [String] = ["Work", "Movie Night", "Blogging", "Add"]
    @State private var selectedProfile: String?

    var body: some View {
        NavigationSplitView {
            List(dummyProfiles, id: \.self, selection: $selectedProfile) { profile in
                if profile == "Add" {
                    Button {
                        dummyProfiles.insert("New (\(dummyProfiles.count))", at: dummyProfiles.count - 1)
                    } label: {
                        Label("New", systemImage: "plus")
                            .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)

                } else {
                    NavigationLink(value: profile, label: {
                        Label(profile, systemImage: "globe")
                    })
                }
            }
        } detail: {
            // TODO: display matching profile for selection
            if selectedProfile != nil {
                ProfilePage(profileViewModel: profileViewModel)
            } else {
                Text("No profile selected")
            }
        }
        .navigationTitle(selectedProfile ?? "")

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
