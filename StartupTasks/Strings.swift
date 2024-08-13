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
    internal static let appsLabel = "Apps"
    internal static let selectAppsToOpen = "Select apps to open after login"
    internal static let theseAppsWillOpen = "These apps will open automatically after login"
    internal static let addNewApp = "Add new app"
    internal static let addNewWebpage = "Add new webpage"
    internal static let addNewFile = "Add new file"
    internal static let addLabel = "Add"
    internal static let cancelLabel = "Cancel"
}
