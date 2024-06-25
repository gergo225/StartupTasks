//
//  ProfileViewModel.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 22.06.2024.
//

import Foundation
import AppKit
import SwiftUI

enum ProfilePageAction {
    case onAddNewApp(appItem: AppItem)
    case onAddNewUrl(url: URL)
    case onRemoveApp(appItem: AppItem)
    case onRemoveUrl(url: URL)
}

class ProfileViewModel: ObservableObject {
    @ObservedObject var appsViewModel: AppsViewModel
    @ObservedObject var urlsViewModel: UrlsViewModel

    private let profile: Profile

    init(profile: Profile) {
        self.profile = profile
        self.appsViewModel = AppsViewModel(apps: profile.apps)
        self.urlsViewModel = UrlsViewModel(urls: profile.urls)

        self.appsViewModel.profileDelegate = self
        self.urlsViewModel.profileDelegate = self
    }
}

extension ProfileViewModel: AppsProfileDelegate, UrlsProfileDelegate {
    func addAppToProfile(appItem: AppItem) {
        guard var currentProfile = currentProfileFromUserDefaults else { return }

        guard !currentProfile.apps.contains(where: { $0.appPath == appItem.appPath }) else { return }
        currentProfile.apps.append(appItem)

        updateCurrentProfileInUserDefaults(newValue: currentProfile)
    }

    func addUrlToProfile(url: URL) {
        guard var currentProfile = currentProfileFromUserDefaults else { return }

        guard !currentProfile.urls.contains(where: { $0 == url }) else { return }
        currentProfile.urls.append(url)

        updateCurrentProfileInUserDefaults(newValue: currentProfile)
    }

    func removeAppFromProfile(appItem: AppItem) {
        guard var currentProfile = currentProfileFromUserDefaults else { return }

        guard let appIndex = currentProfile.apps.firstIndex(where: { $0.appPath == appItem.appPath }) else { return }
        currentProfile.apps.remove(at: appIndex)

        updateCurrentProfileInUserDefaults(newValue: currentProfile)
    }

    func removeUrlFromProfile(url: URL) {
        guard var currentProfile = currentProfileFromUserDefaults else { return }

        guard let urlIndex = currentProfile.urls.firstIndex(where: { $0 == url }) else { return }
        currentProfile.urls.remove(at: urlIndex)

        updateCurrentProfileInUserDefaults(newValue: currentProfile)
    }

    private var currentProfileFromUserDefaults: Profile? {
        LoginDefaults.standard.profiles.first(where: { $0.id == profile.id })
    }

    private func updateCurrentProfileInUserDefaults(newValue: Profile) {
        var profiles = LoginDefaults.standard.profiles

        guard let profileIndex = profiles.firstIndex(where: { $0.id == profile.id }) else { return }
        profiles[profileIndex] = newValue

        LoginDefaults.standard.profiles = profiles
    }
}
