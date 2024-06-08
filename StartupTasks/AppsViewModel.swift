//
//  AppsViewModel.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 03.06.2024.
//

import Foundation

enum AppsPageAction {
    case openAppSelectionList
    case addNewApp(app: AppItem)
}

class AppsPageModel: ObservableObject {
    @Published var addedApps: [AppItem] = []
}

class AppsViewModel: ObservableObject {
    @Published var model: AppsPageModel = AppsPageModel()
    @Published var shouldPresentAppSelection: Bool = false

    func onAction(_ action: AppsPageAction) {
        switch action {
        case .addNewApp(let app):
            addNewApp(app)
        case .openAppSelectionList:
            shouldPresentAppSelection = true
        }
    }
}

private extension AppsViewModel {
    func addNewApp(_ app: AppItem) {
        guard !model.addedApps.contains(where: { $0.name == app.name }) else { return }

        // TODO: save to UserDefaults too
        model.addedApps.append(app)
    }
}
