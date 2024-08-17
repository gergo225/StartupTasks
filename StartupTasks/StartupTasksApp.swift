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
