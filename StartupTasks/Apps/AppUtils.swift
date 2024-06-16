//
//  AppUtils.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 03.06.2024.
//

import Foundation
import AppKit

class AppUtils {
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
