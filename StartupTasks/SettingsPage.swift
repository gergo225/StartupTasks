//
//  Settings.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 28.05.2024.
//

import Foundation
import SwiftUI
import LaunchAtLogin

struct SettingsPage: View {
    var body: some View {
        return Form {
            LaunchAtLogin.Toggle("Launch app at startup")
        }
        .frame(minWidth: 200, minHeight: 80)
        .padding(40)
    }
}

#Preview {
    SettingsPage()
}
