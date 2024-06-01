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
    case submitUrl(urlString: String)
}

class MainModel: ObservableObject {
    @Published var addedUrlToOpen: String? = LoginDefaults.standard.urlToOpen
}

class MainViewModel: ObservableObject {
    @ObservedObject var mainModel: MainModel = MainModel()

    func onAction(_ action: MainAction) {
        switch action {
        case .submitUrl(let urlString):
            submitUrl(urlString: urlString)
        case .launchedAtLoginChanged(let launchedAtLogin):
            onLaunchedAtLoginChanged(to: launchedAtLogin)
        }
    }
}

private extension MainViewModel {
    private func submitUrl(urlString: String) {
        guard let validUrl = URL(string: urlString) else { return }
        LoginDefaults.standard.urlToOpen = validUrl.absoluteString
        mainModel.addedUrlToOpen = validUrl.absoluteString
    }

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
