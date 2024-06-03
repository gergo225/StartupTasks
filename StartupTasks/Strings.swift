//
//  Strings.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 29.05.2024.
//

import Foundation

internal enum Strings {
    internal static let openSettingsToChange = "Open settings to change whether the app starts at login or not"
    internal static let launchAtStartup = "Launch app at startup"
    internal static let emptyValue = "--"
    internal static let urlToAddInputLabel = "URL to open"
    internal static let saveLabel = "Save"
    internal static func willOpenPage(pageUrl: String) -> String {
        "Will open the webpage: \(pageUrl)"
    }
    internal static let websitesLabel = "Websites"
}
