//
//  MainViewModel.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 01.06.2024.
//

import Foundation
import AppKit
import SwiftUI
import Combine

enum MainAction {
    case launchedAtLoginChanged(launchedAtLogin: Bool)
    case addProfilePressed
}

class MainModel: ObservableObject {
    @Published var profiles: [Profile] = LoginDefaults.standard.profiles
}

class MainViewModel: ObservableObject {
    @ObservedObject var model: MainModel = MainModel()

    private var subscriptions = Set<AnyCancellable>()

    init() {
        LoginDefaults.standard.changed.map { $0.profiles }
            .sink { [weak self] profiles in
                guard let self else { return }
                model.profiles = profiles
            }
            .store(in: &subscriptions)
    }

    func onAction(_ action: MainAction) {
        switch action {
        case .launchedAtLoginChanged(let launchedAtLogin):
            onLaunchedAtLoginChanged(to: launchedAtLogin)
        case .addProfilePressed:
            onAddProfilePressed()
        }
    }
}

private extension MainViewModel {
    func onLaunchedAtLoginChanged(to launchedAtLogin: Bool) {
        guard launchedAtLogin, !LoginDefaults.standard.finishedStartupProcess else { return }
        LoginDefaults.standard.finishedStartupProcess = true
        runStartupProcesses()
    }

    func onAddProfilePressed() {
        let emptyUrls: [URL] = []
        let newProfile = Profile(name: "New Profile (\(model.profiles.count))", apps: emptyUrls, urls: emptyUrls)

        var profileDefaults = LoginDefaults.standard.profiles
        profileDefaults.append(newProfile)
        LoginDefaults.standard.profiles = profileDefaults

        model.profiles.append(newProfile)
    }
}

private extension MainViewModel {
    private func runStartupProcesses() {
        openAddedUrls()
        openAddedApps()
    }

    // TODO: open later based on which profile is set as "startup profile" (ie. which to run right after login)
    private func openAddedUrls() {
//        let urls = LoginDefaults.standard.urlsToOpen
//
//        urls.forEach { url in
//            NSWorkspace.shared.open(url)
//        }
    }

    private func openAddedApps() {
//        let appPaths = LoginDefaults.standard.appPathsToOpen
//        let openConfiguration = NSWorkspace.OpenConfiguration()
//        appPaths.forEach { appPath in
//            NSWorkspace.shared.openApplication(at: appPath, configuration: openConfiguration)
//        }
    }
}
