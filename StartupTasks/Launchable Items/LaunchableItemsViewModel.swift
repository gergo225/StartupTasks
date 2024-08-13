//
//  LaunchableItemsViewModel.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 12.08.2024.
//

import Foundation

class LaunchableItemsViewModel<ItemType: LaunchableItem>: ObservableObject {
    enum Action {
        case addItem(item: ItemType)
        case removeItem(item: ItemType)
        case addItemPressed
        case cancelAddNewItem
    }

    @Published var shouldPresentAddDialog: Bool = false
    @Published var items: [ItemType] = []

    init(items: [ItemType]) {
        self.items = items
    }

    func onAction(_ action: Action) {
        switch action {
        case .addItem(let item):
            addItem(item)
            shouldPresentAddDialog = false
        case .removeItem(let item):
            removeItem(item)
        case .addItemPressed:
            shouldPresentAddDialog = true
        case .cancelAddNewItem:
            shouldPresentAddDialog = false
        }
    }
    
    // TODO: how to make these to required to be overridden?
    func addItem(_ item: ItemType) { }

    func removeItem(_ item: ItemType) { }
}
