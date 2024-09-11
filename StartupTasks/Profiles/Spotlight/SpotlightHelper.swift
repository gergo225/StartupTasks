//
//  SpotlightHelper.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 09.09.2024.
//

import Foundation
import CoreSpotlight

final class SpotlightHelper {
    private let defaultSearchableIndex = CSSearchableIndex.default()

    func addProfilesToSpotlightSearch(_ profiles: [Profile]) {
        let searchableItems = profiles.map(convertProfileToSearchableItem)

        defaultSearchableIndex.indexSearchableItems(searchableItems)
    }

    func deleteProfileFromSpotlightSearch(_ profile: Profile) {
        defaultSearchableIndex.deleteSearchableItems(withIdentifiers: [profile.id.uuidString])
    }

    private func convertProfileToSearchableItem(_ profile: Profile) -> CSSearchableItem {
        let attributeSet = getSearchableItemAttributeSet(for: profile)
        return CSSearchableItem(uniqueIdentifier: profile.id.uuidString, domainIdentifier: nil, attributeSet: attributeSet)
    }

    private func getSearchableItemAttributeSet(for profile: Profile) -> CSSearchableItemAttributeSet {
        let attributeSet = CSSearchableItemAttributeSet(contentType: .executable)
        attributeSet.title = profile.name
        attributeSet.contentDescription = Strings.openAppsFilesAndWebpages

        return attributeSet
    }
}
