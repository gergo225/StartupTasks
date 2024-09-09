//
//  Strings.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 29.05.2024.
//

import Foundation

internal enum Strings {
    internal static let menuBarExtraTitle = "Startup Tasks"
    internal static let launchAtStartup = "Launch app at startup"
    internal static let websitesLabel = "Websites"
    internal static let appsLabel = "Apps"
    internal static let filesLabel = "Files"
    internal static let addNewApp = "Add new app"
    internal static let addNewWebpage = "Add new webpage"
    internal static let addNewFile = "Add new file"
    internal static let addLabel = "Add"
    internal static let cancelLabel = "Cancel"
    internal static let confirmLabel = "Confirm"
    internal static let renameLabel = "Rename"
    internal static let deleteLabel = "Delete"
    internal static let newLabel = "New"
    internal static let noProfilesToRun = "No profiles to run"
    internal static let noProfileSelected = "No profile selected"
    internal static let startProfile = "Start profile"
    internal static let newProfile = "New Profile"
    internal static func newProfileNumbered(_ number: Any) -> String {
        return "New Profile (\(number))"
    }
    internal static let createNewProfile = "Create new profile"
    internal static let errorAccessingFile = "Error accessing file"
    internal static let websiteToOpen = "Website to open"
}
