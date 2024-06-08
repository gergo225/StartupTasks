//
//  AppUtils.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 03.06.2024.
//

import Foundation
import AppKit

class AppUtils {
    static func getIconForApp(named appName: String) -> NSImage? {
        guard let path = getIconPathForUserApp(named: appName) ?? getIconPathForSystemApp(named: appName) else { return nil }
        return NSWorkspace.shared.icon(forFile: path)
    }

    private static func getIconPathForUserApp(named appName: String) -> String? {
        let path = "/Applications/\(appName).app/"
        return fileExists(atPath: path) ? path : nil
    }
    
    private static func getIconPathForSystemApp(named appName: String) -> String? {
        let path = "/System/Applications/\(appName).app/"

        return fileExists(atPath: path) ? path: nil
    }

    private static func fileExists(atPath filePath: String) -> Bool {
        let fileManager = FileManager.default
        return fileManager.fileExists(atPath: filePath)
    }
}

extension AppUtils {
    static func getAllAppPaths() -> [URL] {
        var appPaths = [URL]()

        let fileManager = FileManager.default

        if let userAppUrls = fileManager.urls(for: .applicationDirectory, in: .localDomainMask).first {
            let userApps = getAllAppPaths(in: userAppUrls)
            appPaths.append(contentsOf: userApps)
        }

        if let systemAppUrls = fileManager.urls(for: .applicationDirectory, in: .systemDomainMask).first {
            let systemApps = getAllAppPaths(in: systemAppUrls)
            appPaths.append(contentsOf: systemApps)
        }

        return appPaths
    }

    private static func getAllAppPaths(in directoryUrl: URL) -> [URL] {
        var appPaths = [URL]()

        let fileManager = FileManager.default

        if let enumerator = fileManager.enumerator(at: directoryUrl, includingPropertiesForKeys: nil, options: .skipsSubdirectoryDescendants) {
            while let element = enumerator.nextObject() as? URL {
                if element.pathExtension == "app" { // checks the extension
                    appPaths.append(element)
                }
            }
        }

        return appPaths
    }
}
