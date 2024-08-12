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
    @ObservedObject var filesViewModel: FilesViewModel

    @ObservationIgnored
    private let dataSource: ProfilesDataSource

    private let profile: Profile

    init(profile: Profile) {
        self.profile = profile
        self.appsViewModel = AppsViewModel(apps: profile.apps)
        self.urlsViewModel = UrlsViewModel(urls: profile.urls)
        self.filesViewModel = FilesViewModel(filePaths: profile.filePaths)
        self.dataSource = ProfilesDataSourceImpl.shared

        self.appsViewModel.profileDelegate = self
        self.urlsViewModel.profileDelegate = self
        self.filesViewModel.profileDelegate = self
    }
}

extension ProfileViewModel: AppsProfileDelegate, UrlsProfileDelegate, FilesProfileDelegate {
    func addFileToProfile(filePath: URL) {
        guard !profile.filePaths.contains(where: { $0 == filePath }) else { return }

        performProfileUpdate {
            $0.filePaths.append(filePath)
            return $0
        }
    }

    func removeFileFromProfile(filePath: URL) {
        guard let filePathIndex = profile.filePaths.firstIndex(where: { $0 == filePath }) else { return }

        performProfileUpdate {
            $0.filePaths.remove(at: filePathIndex)
            return $0
        }
    }

    func addAppToProfile(appItem: AppItem) {
        guard !profile.apps.contains(where: { $0.path == appItem.path }) else { return }

        performProfileUpdate {
            $0.apps.append(appItem)
            return $0
        }
    }

    func addUrlToProfile(url: URL) {
        guard !profile.urls.contains(where: { $0 == url }) else { return }

        performProfileUpdate {
            $0.urls.append(url)
            return $0
        }
    }

    func removeAppFromProfile(appItem: AppItem) {
        guard let appIndex = profile.apps.firstIndex(where: { $0.path == appItem.path }) else { return }

        performProfileUpdate {
            $0.apps.remove(at: appIndex)
            return $0
        }
    }

    func removeUrlFromProfile(url: URL) {
        guard let urlIndex = profile.urls.firstIndex(where: { $0 == url }) else { return }

        performProfileUpdate {
            $0.urls.remove(at: urlIndex)
            return $0
        }
    }

    private func performProfileUpdate(updatedProfile: (Profile) -> Profile) {
        let updatedProfile = updatedProfile(profile)

        dataSource.updateProfileItems(profile.id, newProfileWithItems: updatedProfile)
    }
}
