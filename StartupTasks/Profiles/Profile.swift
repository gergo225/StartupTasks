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
    var filePaths: [URL]

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
