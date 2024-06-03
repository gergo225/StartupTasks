//
//  MainViewModel.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 01.06.2024.
//

import Foundation
import AppKit
import SwiftUI

enum MainAction {
    case launchedAtLoginChanged(launchedAtLogin: Bool)
}

class MainViewModel: ObservableObject {
    func onAction(_ action: MainAction) {
        switch action {
        case .launchedAtLoginChanged(let launchedAtLogin):
            onLaunchedAtLoginChanged(to: launchedAtLogin)
        }
    }
}

private extension MainViewModel {
    private func onLaunchedAtLoginChanged(to launchedAtLogin: Bool) {
        guard launchedAtLogin, !LoginDefaults.standard.finishedStartupProcess else { return }
        LoginDefaults.standard.finishedStartupProcess = true
        runStartupProcesses()
    }
}

private extension MainViewModel {
    private func runStartupProcesses() {
        openAddedUrl()
    }

    private func openAddedUrl() {
        guard let urlString = LoginDefaults.standard.urlToOpen, let urlToOpen = URL(string: urlString) else { return }
        NSWorkspace.shared.open(urlToOpen)
    }
}
