//
//  AppsViewModel.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 03.06.2024.
//

import Foundation

enum AppsPageAction {
    case addApp(app: AppItem)
    case removeApp(app: AppItem)
    case openAppSelectionList
    case cancelAddNewApp
}

class AppsPageModel: ObservableObject {
    @Published var addedApps: [AppItem] = LoginDefaults.standard.appPathsToOpen.compactMap { AppItem(appPath: $0) }
}

class AppsViewModel: ObservableObject {
    @Published var model: AppsPageModel = AppsPageModel()
    @Published var shouldPresentAppSelection: Bool = false

    func onAction(_ action: AppsPageAction) {
        switch action {
        case .addApp(let app):
            addApp(app)
            shouldPresentAppSelection = false
        case .removeApp(let app):
            removeApp(app)
        case .openAppSelectionList:
            shouldPresentAppSelection = true
        case .cancelAddNewApp:
            shouldPresentAppSelection = false
        }
    }
}

private extension AppsViewModel {
    func addApp(_ app: AppItem) {
        guard !model.addedApps.contains(where: { $0.appPath == app.appPath }) else { return }

        var appPathsToOpen = LoginDefaults.standard.appPathsToOpen
        appPathsToOpen.append(app.appPath)
        LoginDefaults.standard.appPathsToOpen = appPathsToOpen
        
        model.addedApps.append(app)
    }

    func removeApp(_ app: AppItem) {
        var appPathsToOpen = LoginDefaults.standard.appPathsToOpen
        if let appPathIndex = appPathsToOpen.firstIndex(of: app.appPath) {
            appPathsToOpen.remove(at: appPathIndex)
            LoginDefaults.standard.appPathsToOpen = appPathsToOpen
        }

        if let appIndex = model.addedApps.firstIndex(of: app) {
            model.addedApps.remove(at: appIndex)
        }
    }
}
