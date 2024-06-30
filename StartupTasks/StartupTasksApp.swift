//
//  StartupTasksApp.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 25.05.2024.
//

import SwiftUI
import AppKit
import LaunchAtLogin

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        LoginDefaults.standard.launchedAtLogin = LaunchAtLogin.wasLaunchedAtLogin
        LoginDefaults.standard.finishedStartupProcess = false
    }
}

@main
struct StartupTasksApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            MainView()
        }

        MenuBarProfiles()

        Settings {
            SettingsPage()
        }
    }
}
