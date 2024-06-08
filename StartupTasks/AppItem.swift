//
//  AppItem.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 03.06.2024.
//

import Foundation
import AppKit

struct AppItem: Hashable {
    var name: String
    var icon: NSImage?

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

extension AppItem {
    init?(appPath: URL) {
        let pathExists = FileManager.default.fileExists(atPath: appPath.relativePath)
        let pathIsValidApp = appPath.pathExtension == "app"

        guard pathExists, pathIsValidApp else { return nil }

        self.name = appPath.deletingPathExtension().lastPathComponent
        self.icon = AppUtils.getIconForApp(named: name)
    }
}
