//
//  MenuBarProfilesViewModel.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 30.06.2024.
//

import Foundation
import Combine

final class MenuBarProfilesViewModel: ObservableObject {
    @Published private(set) var profiles: [Profile] = []

    @ObservationIgnored
    private let dataSource: ProfilesDataSource
    
    private var subscriptions = Set<AnyCancellable>()

    init() {
        dataSource = ProfilesDataSourceImpl.shared
        subscribeToProfileChanges()
    }

    private func subscribeToProfileChanges() {
        dataSource.changed.sink { [weak self] profiles in
            self?.profiles = profiles
        }
        .store(in: &subscriptions)
    }

    func onProfileSelected(_ profile: Profile) {
        ProfileUtils.startProfile(profile)
    }
}
