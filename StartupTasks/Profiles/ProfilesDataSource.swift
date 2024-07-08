//
//  ProfilesDataSource.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 04.07.2024.
//

import Foundation
import Combine

protocol ProfilesDataSource {
    var changed: AnyPublisher<[Profile], Never> { get }

    func fetchProfiles() -> [Profile]
    func addProfile(_ profile: Profile)
    func removeProfile(_ id: UUID)
    func renameProfile(_ id: UUID, newName: String)

    func updateProfileItems(_ id: UUID, newProfileWithItems: Profile)
}
