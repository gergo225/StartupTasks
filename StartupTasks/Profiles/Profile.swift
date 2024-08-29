//
//  Profile.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 23.06.2024.
//

import Foundation
import SwiftData

@Model
class Profile: Hashable, Identifiable {
    @Attribute(.unique)
    var id: UUID
    var name: String
    var apps: [AppItem]
    var urls: [URL]

    @Transient
    var filePaths: [URL] {
        get {
            var staleUrlExists: Bool = false

            let urls: [URL] = filePathsData.compactMap {
                var isStale: Bool = false
                guard let url = try? URL(resolvingBookmarkData: $0, options: .withSecurityScope, bookmarkDataIsStale: &isStale) else {
                    return nil
                }

                if (isStale) {
                    staleUrlExists = true
                }

                return url
            }

            if staleUrlExists {
                filePathsData = urls.compactMap { $0.createBookmarkData() }
            }

            return urls
        }
        set {
            filePathsData = newValue.compactMap { $0.createBookmarkData() }
        }
    }

    private var filePathsData: [Data] = []

    init(id: UUID, name: String, apps: [AppItem], urls: [URL], filePaths: [URL]) {
        self.id = id
        self.name = name
        self.apps = apps
        self.urls = urls
        self.filePaths = filePaths
    }
}

extension Profile {
    convenience init(name: String, apps: [URL], urls: [URL], filePaths: [URL]) {
        let apps = apps.compactMap { AppItem(appPath: $0) }
        self.init(id: UUID(), name: name, apps: apps, urls: urls, filePaths: filePaths)
    }
}

private extension URL {
    func createBookmarkData() -> Data? {
        guard startAccessingSecurityScopedResource() else {
            return nil
        }
        defer {
            stopAccessingSecurityScopedResource()
        }

        return try? bookmarkData(options: .securityScopeAllowOnlyReadAccess)
    }
}
