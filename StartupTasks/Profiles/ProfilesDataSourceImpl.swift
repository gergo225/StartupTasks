//
//  ProfilesDataSource.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 04.07.2024.
//

import SwiftData
import CoreData
import Combine

final class ProfilesDataSourceImpl: ProfilesDataSource {
    private let changedInput: PassthroughSubject<[Profile], Never>
    var changed: AnyPublisher<[Profile], Never>

    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = ProfilesDataSourceImpl()

    @MainActor
    private init() {
        modelContainer = try! ModelContainer(for: Profile.self, AppItem.self)
        modelContext = modelContainer.mainContext
        changedInput = PassthroughSubject<[Profile], Never>()
        changed = changedInput.shareLatest()
    }

    func fetchProfiles() -> [Profile] {
        do {
            return try modelContext.fetch(FetchDescriptor<Profile>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func addProfile(_ profile: Profile) {
        modelContext.insert(profile)
        do {
            try modelContext.save()
            changedInput.send(fetchProfiles())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func removeProfile(_ id: UUID) {
        do {
            try modelContext.delete(model: Profile.self, where: #Predicate { $0.id == id })
            changedInput.send(fetchProfiles())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func renameProfile(_ id: UUID, newName: String) {
        let fetchDescriptor = FetchDescriptor<Profile>(predicate: #Predicate { $0.id == id })
        do {
            guard let profile = try modelContext.fetch(fetchDescriptor).first else { return }
            profile.name = newName
            try modelContext.save()
            changedInput.send(fetchProfiles())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func updateProfileItems(_ id: UUID, newProfileWithItems: Profile) {
        let fetchDescriptor = FetchDescriptor<Profile>(predicate: #Predicate { $0.id == id })
        do {
            guard let profile = try modelContext.fetch(fetchDescriptor).first else { return }
            profile.apps = newProfileWithItems.apps
            profile.urls = newProfileWithItems.urls
            try modelContext.save()
            changedInput.send(fetchProfiles())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
