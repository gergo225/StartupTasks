//
//  MenuBarProfilesViewModel.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 30.06.2024.
//

import Foundation
import Combine

final class MenuBarProfilesViewModel: ObservableObject {
    @Published private(set) var profiles: [Profile] = LoginDefaults.standard.profiles

    private var subscriptions = Set<AnyCancellable>()

    init() {
        subscribeToProfileChanges()
    }

    private func subscribeToProfileChanges() {
        LoginDefaults.standard.changed.map { $0.profiles }.sink { [weak self] profiles in
            guard let self else { return }
            self.profiles = profiles
        }
        .store(in: &subscriptions)
    }

    func onProfileSelected(_ profile: Profile) {
        ProfileUtils.startProfile(profile)
    }
}
