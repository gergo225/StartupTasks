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
            .sheet(item: $viewModel.profileToRename) { profile in
                renameProfilePage(for: profile)
            }
    }

    private func renameProfilePage(for profile: Profile) -> some View {
        TextInputPrompt(
            onConfirm: { inputString in
                viewModel.onAction(.renameProfile(profile: profile, newName: inputString))
            },
            onCancel: {
                viewModel.onAction(.cancelProfileRename)
            },
            confirmButtonString: Strings.renameLabel,
            textPrompt: profile.name
        )
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
                    profileItem(for: profile)
                }

                addNewProfileButton
            }
        } detail: {
            if let selectedProfile {
                ProfileRouter.profilePage(for: selectedProfile)
            } else {
                noProfilesView
            }
        }
        .navigationTitle(selectedProfile?.name ?? "")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    guard let selectedProfile else { return }
                    onAction(.startProfilePressed(profile: selectedProfile))
                } label: {
                    Image(systemName: "play.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .padding(8)
                        .clipShape(.rect(cornerRadius: 8))
                }
                .help(Strings.startProfile)
            }
        }
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

    private func profileItem(for profile: Profile) -> some View {
        NavigationLink(value: profile, label: {
            Label(profile.name, systemImage: "folder")
        })
        .contextMenu {
            Button(Strings.renameLabel) {
                onAction(.renameProfilePressed(profile: profile))
            }

            Button(Strings.deleteLabel, role: .destructive) {
                onAction(.removeProfile(profile: profile))
                if selectedProfile == profile {
                    selectedProfile = model.profiles.first
                }
            }
        }
    }

    private var addNewProfileButton: some View {
        Button {
            onAction(.addProfilePressed)
        } label: {
            Label(Strings.newLabel, systemImage: "plus")
                .foregroundStyle(.secondary)
                .padding([.vertical, .leading])
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(.buttonBorder)
        }
        .buttonStyle(.plain)
    }

    private var noProfilesView: some View {
        VStack(alignment: .center) {
            Text(Strings.noProfileSelected)
            Button {
                onAction(.addProfilePressed)
            } label: {
                Label(Strings.createNewProfile, systemImage: "plus")
                    .padding(.vertical, 4)
                    .frame(maxWidth: 200)
            }
            .buttonStyle(.borderedProminent)
        }
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

    let filePaths: [URL] = [
        URL(string: "/Users/fazekasgergo/Music/Music/Music Library.musiclibrary")!,
        URL(string: "/Users/fazekasgergo/Music/Music")!
    ]

    let profile = Profile(name: "Live Coding", apps: appPaths, urls: urls, filePaths: filePaths)

    let model = MainModel()
    model.profiles = [profile]
    let viewModel = MainViewModel()
    viewModel.model = model

    return MainView(viewModel: viewModel)
}
