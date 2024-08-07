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

    @ObservationIgnored
    private let dataSource: ProfilesDataSource

    private let profile: Profile

    init(profile: Profile) {
        self.profile = profile
        self.appsViewModel = AppsViewModel(apps: profile.apps)
        self.urlsViewModel = UrlsViewModel(urls: profile.urls)
        self.dataSource = ProfilesDataSourceImpl.shared

        self.appsViewModel.profileDelegate = self
        self.urlsViewModel.profileDelegate = self
    }
}

extension ProfileViewModel: AppsProfileDelegate, UrlsProfileDelegate {
    func addAppToProfile(appItem: AppItem) {
        guard !profile.apps.contains(where: { $0.appPath == appItem.appPath }) else { return }

        var updatedProfile = profile
        updatedProfile.apps.append(appItem)

        dataSource.updateProfileItems(profile.id, newProfileWithItems: updatedProfile)
    }

    func addUrlToProfile(url: URL) {
        guard !profile.urls.contains(where: { $0 == url }) else { return }

        var updatedProfile = profile
        updatedProfile.urls.append(url)

        dataSource.updateProfileItems(profile.id, newProfileWithItems: updatedProfile)
    }

    func removeAppFromProfile(appItem: AppItem) {
        guard let appIndex = profile.apps.firstIndex(where: { $0.appPath == appItem.appPath }) else { return }

        var updatedProfile = profile
        updatedProfile.apps.remove(at: appIndex)

        dataSource.updateProfileItems(profile.id, newProfileWithItems: updatedProfile)
    }

    func removeUrlFromProfile(url: URL) {
        guard let urlIndex = profile.urls.firstIndex(where: { $0 == url }) else { return }

        var updatedProfile = profile
        updatedProfile.urls.remove(at: urlIndex)

        dataSource.updateProfileItems(profile.id, newProfileWithItems: updatedProfile)
    }
}
