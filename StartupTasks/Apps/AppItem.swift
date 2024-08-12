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
class AppItem: LaunchableItem {
    private var appPath: URL

    init?(appPath: URL) {
        let pathExists = FileManager.default.fileExists(atPath: appPath.relativePath)
        let pathIsValidApp = appPath.pathExtension == "app"

        guard pathExists, pathIsValidApp else { return nil }

        self.appPath = appPath
    }

    @Transient
    var name: String {
        appPath.deletingPathExtension().lastPathComponent
    }

    @Transient
    var path: URL {
        appPath
    }

    @Transient
    var icon: NSImage? {
        NSWorkspace.shared.icon(forFile: appPath.relativePath)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(appPath)
    }
}
