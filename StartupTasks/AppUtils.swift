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
