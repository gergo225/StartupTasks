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
    case startProfilePressed(profile: Profile)
}

class MainModel: ObservableObject {
    @Published var profiles: [Profile] = []
}

class MainViewModel: ObservableObject {
    @ObservedObject var model: MainModel = MainModel()
    @Published var profileToRename: Profile? = nil

    @ObservationIgnored
    private let dataSource: ProfilesDataSource

    private var subscriptions = Set<AnyCancellable>()

    init() {
        dataSource = ProfilesDataSourceImpl.shared
        model.profiles = dataSource.fetchProfiles()
        subscribeToProfileChanges()

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
        case .startProfilePressed(let profile):
            ProfileUtils.startProfile(profile)
        }
    }
}

private extension MainViewModel {
    func addDefaultProfileIfNeeded() {
        guard model.profiles.isEmpty else { return }
        guard let defaultProfile else { return }
        dataSource.addProfile(defaultProfile)
    }

    private var defaultProfile: Profile? {
        guard let app = AppUtils.getAllAppPaths().randomElement(),
              let url = URL(string: "youtube.com")
        else { return nil }

        return Profile(name: "Default", apps: [app], urls: [url])
    }

    func subscribeToProfileChanges() {
        dataSource.changed.sink { [weak self] profiles in
            self?.model.profiles = profiles
        }
        .store(in: &subscriptions)
    }
}

private extension MainViewModel {
    func onLaunchedAtLoginChanged(to launchedAtLogin: Bool) {
        guard launchedAtLogin, !LoginDefaults.standard.finishedStartupProcess else { return }
        LoginDefaults.standard.finishedStartupProcess = true
//        runStartupProcesses() // TODO: add later which profile to start by default (after login)
    }

    func onAddProfilePressed() {
        let emptyUrls: [URL] = []
        let newProfileName = model.profiles.count == 0 ? "New Profile" : "New Profile (\(model.profiles.count)"
        let newProfile = Profile(name: newProfileName, apps: emptyUrls, urls: emptyUrls)

        dataSource.addProfile(newProfile)
    }

    func removeProfile(_ profile: Profile) {
        dataSource.removeProfile(profile.id)
    }

    func renameProfile(_ profile: Profile, newName: String) {
        guard profile.name != newName else { return }
        
        dataSource.renameProfile(profile.id, newName: newName)
    }
}
