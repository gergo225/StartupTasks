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
    case removeProfile(profile: Profile)
    case renameProfilePressed(profile: Profile)
    case cancelProfileRename
    case renameProfile(profile: Profile, newName: String)
}

class MainModel: ObservableObject {
    @Published var profiles: [Profile] = LoginDefaults.standard.profiles
}

class MainViewModel: ObservableObject {
    @ObservedObject var model: MainModel = MainModel()
    @Published var profileToRename: Profile? = nil

    private var subscriptions = Set<AnyCancellable>()

    init() {
        subscribeToPersistedProfileChanges()

        addDefaultProfileIfNeeded()
    }

    func onAction(_ action: MainAction) {
        switch action {
        case .launchedAtLoginChanged(let launchedAtLogin):
            onLaunchedAtLoginChanged(to: launchedAtLogin)
        case .addProfilePressed:
            onAddProfilePressed()
        case .removeProfile(let profile):
            removeProfile(profile)
        case .renameProfilePressed(let profile):
            profileToRename = profile
        case .cancelProfileRename:
            profileToRename = nil
        case .renameProfile(let profile, let newName):
            renameProfile(profile, newName: newName)
            profileToRename = nil
        }
    }
}

private extension MainViewModel {
    func addDefaultProfileIfNeeded() {
        guard model.profiles.isEmpty else { return }
        guard let defaultProfile else { return }
        LoginDefaults.standard.profiles = [defaultProfile]
    }

    private var defaultProfile: Profile? {
        guard let app = AppUtils.getAllAppPaths().randomElement(),
              let url = URL(string: "youtube.com")
        else { return nil }

        return Profile(name: "Default", apps: [app], urls: [url])
    }

    func subscribeToPersistedProfileChanges() {
        LoginDefaults.standard.changed.map { $0.profiles }
            .sink { [weak self] profiles in
                guard let self else { return }
                model.profiles = profiles
            }
            .store(in: &subscriptions)
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
    }

    func removeProfile(_ profile: Profile) {
        var profiles = LoginDefaults.standard.profiles
        guard let profileIndex = profiles.firstIndex(where: { $0.id == profile.id }) else { return }
        profiles.remove(at: profileIndex)
        LoginDefaults.standard.profiles = profiles
    }

    func renameProfile(_ profile: Profile, newName: String) {
        guard profile.name != newName else { return }
        
        var profiles = LoginDefaults.standard.profiles
        guard let profileIndex = profiles.firstIndex(where: { $0.id == profile.id }) else { return }
        profiles[profileIndex].name = newName
        LoginDefaults.standard.profiles = profiles
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
