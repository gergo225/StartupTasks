//
//  ProfileUtils.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 30.06.2024.
//

import Foundation
import AppKit

final class ProfileUtils {
    static func startProfile(_ profile: Profile) {
        openUrls(profile.urls)
        openApps(profile.apps.map { $0.path })
        openFiles(profile.filePaths)
    }

    private static func openUrls(_ urls: [URL]) {
        urls.forEach { url in
            NSWorkspace.shared.open(url.withHttp)
        }
    }

    private static func openApps(_ appPaths: [URL]) {
        let openConfiguration = NSWorkspace.OpenConfiguration()
        appPaths.forEach { appPath in
            NSWorkspace.shared.openApplication(at: appPath, configuration: openConfiguration)
        }
    }

    private static func openFiles(_ filePaths: [URL]) {
        let fileManager = FileManager.default

        filePaths
            .filter { fileManager.fileExists(atPath: $0.relativePath) }
            .forEach { filePath in
                guard filePath.startAccessingSecurityScopedResource() else {
                    print(Strings.errorAccessingFile)
                    return
                }
                defer {
                    filePath.stopAccessingSecurityScopedResource()
                }

                NSWorkspace.shared.open(filePath.absoluteURL)
            }
    }
}
