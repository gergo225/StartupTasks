//
//  AppsViewModel.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 03.06.2024.
//

import Foundation

enum AppsPageAction {
    case addNewApp(appName: String)
}

class AppsPageModel: ObservableObject {
    @Published var addedApps: [AppItem] = AppItemTests.testAppItems
}

class AppsViewModel: ObservableObject {
    @Published var model: AppsPageModel = AppsPageModel()

    func onAction(_ action: AppsPageAction) {
        switch action {
        case .addNewApp(let appName):
            addNewApp(named: appName)
        }
    }
}

private extension AppsViewModel {
    func addNewApp(named appName: String) {
        guard !model.addedApps.contains(where: { $0.name == appName }) else { return }

        let appIcon = AppUtils.getIconForApp(named: appName)
        let app = AppItem(name: appName, icon: appIcon)

        // TODO: save to UserDefaults too
        model.addedApps.append(app)
    }
}

private class AppItemTests {
    static var testAppItems: [AppItem] = [
        AppItem(name: "Google Chrome", icon: AppUtils.getIconForApp(named: "Google Chrome")),
        AppItem(name: "XCode", icon: AppUtils.getIconForApp(named: "XCode")),
        AppItem(name: "Vysor", icon: AppUtils.getIconForApp(named: "Vysor")),
        AppItem(name: "GuitarTuna", icon: AppUtils.getIconForApp(named: "GuitarTuna")),
        AppItem(name: "Visual Studio Code", icon: AppUtils.getIconForApp(named: "Visual Studio Code"))
    ]
}
