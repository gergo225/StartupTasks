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

        closeAppAfterAllAppsStarted(apps: profile.apps.map { $0.path })
    }

    private func closeAppAfterAllAppsStarted(apps: [URL]) {
        let timerCountLimit = 20
        var timerCount = 0

        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { timer in
            timerCount += 1

            let allAppsStarted = apps.allSatisfy { AppUtils.appIsStarted($0) }

            if timerCount > timerCountLimit || allAppsStarted {
                timer.invalidate()
                NSApplication.shared.terminate(nil)
            }
        }
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
