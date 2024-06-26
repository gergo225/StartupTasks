//
//  AppsViewModel.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 03.06.2024.
//

import Foundation

protocol AppsProfileDelegate: AnyObject {
    func addAppToProfile(appItem: AppItem)
    func removeAppFromProfile(appItem: AppItem)
}

enum AppsPageAction {
    case addApp(app: AppItem)
    case removeApp(app: AppItem)
    case addAppPressed
    case cancelAddNewApp
}

class AppsPageModel: ObservableObject {
    @Published var addedApps: [AppItem] = []
}

class AppsViewModel: ObservableObject {
    @Published var model: AppsPageModel
    @Published var shouldPresentAppSelection: Bool = false

    weak var profileDelegate: AppsProfileDelegate?

    init(apps: [AppItem]) {
        let model = AppsPageModel()
        model.addedApps = apps
        self.model = model
    }

    func onAction(_ action: AppsPageAction) {
        switch action {
        case .addApp(let app):
            addApp(app)
            shouldPresentAppSelection = false
        case .removeApp(let app):
            removeApp(app)
        case .addAppPressed:
            shouldPresentAppSelection = true
        case .cancelAddNewApp:
            shouldPresentAppSelection = false
        }
    }
}

private extension AppsViewModel {
    func addApp(_ app: AppItem) {
        profileDelegate?.addAppToProfile(appItem: app)
    }

    func removeApp(_ app: AppItem) {
        profileDelegate?.removeAppFromProfile(appItem: app)
    }
}
