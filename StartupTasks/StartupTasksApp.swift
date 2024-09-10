//
//  StartupTasksApp.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 25.05.2024.
//

import SwiftUI
import AppKit
import LaunchAtLogin
import FluidMenuBarExtra

class AppDelegate: NSObject, NSApplicationDelegate {
    private var menuBarExtra: FluidMenuBarExtra?

    func applicationDidFinishLaunching(_ notification: Notification) {
        LoginDefaults.standard.launchedAtLogin = LaunchAtLogin.wasLaunchedAtLogin
        LoginDefaults.standard.finishedStartupProcess = false
        
        menuBarExtra = FluidMenuBarExtra(title: Strings.menuBarExtraTitle) {
            MenuBarProfiles()
        }
    }

    func application(_ application: NSApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([NSUserActivityRestoring]) -> Void) -> Bool {
        guard let userInfo = userActivity.userInfo,
              let uuidString = userInfo["kCSSearchableItemActivityIdentifier"] as? String,
              let profileUuid = UUID(uuidString: uuidString) else { return false }

        handleStartFromSpotlight(profileUuid: profileUuid)
        return true
    }

    private func handleStartFromSpotlight(profileUuid: UUID) {
        let profilesDataSource = ProfilesDataSourceImpl.shared

        guard let profile = profilesDataSource.fetchProfiles().first(where: { $0.id == profileUuid }) else { return }
        ProfileUtils.startProfile(profile)
    }
}

@main
struct StartupTasksApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            MainView()
        }

        Settings {
            SettingsPage()
        }
    }
}
