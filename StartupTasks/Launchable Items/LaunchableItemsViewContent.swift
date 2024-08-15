//
//  LaunchableItemsViewContent.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 13.08.2024.
//

import SwiftUI

struct LaunchableItemsViewContent<ItemType, ItemView>: View where ItemType: LaunchableItem, ItemView: View {
    let items: [ItemType]
    let onAction: (LaunchableItemsViewModel<ItemType>.Action) -> Void
    let addButtonText: String
    @ViewBuilder var itemView: (ItemType) -> ItemView

    @State private var hoveredItem: AppItem?

    var body: some View {
        VStack {
            EditableList(items: items, addButtonText: addButtonText) { item in
                itemView(item)
            } onAddPressed: {
                onAction(.addItemPressed)
            } onRemove: { item in
                onAction(.removeItem(item: item))
            }
        }
    }
}
