//
//  AppItem.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 03.06.2024.
//

import Foundation
import AppKit
import SwiftData

@Model
class AppItem: Hashable {
    var name: String
    var appPath: URL

    var icon: NSImage? {
        NSWorkspace.shared.icon(forFile: appPath.relativePath)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(appPath)
    }

    private init(name: String, appPath: URL) {
        self.name = name
        self.appPath = appPath
    }
}

extension AppItem {
    convenience init?(appPath: URL) {
        let pathExists = FileManager.default.fileExists(atPath: appPath.relativePath)
        let pathIsValidApp = appPath.pathExtension == "app"

        guard pathExists, pathIsValidApp else { return nil }

        let name = appPath.deletingPathExtension().lastPathComponent
        self.init(name: name, appPath: appPath)
    }
}
