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

class AppsViewModel: LaunchableItemsViewModel<AppItem> {
    weak var profileDelegate: AppsProfileDelegate?

    init(apps: [AppItem]) {
        super.init(items: apps)
    }

    override func addItem(_ item: AppItem) {
        profileDelegate?.addAppToProfile(appItem: item)
    }

    override func removeItem(_ item: AppItem) {
        profileDelegate?.removeAppFromProfile(appItem: item)
    }
}
