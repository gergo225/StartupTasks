//
//  LaunchableItemsViewContent.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 13.08.2024.
//

import SwiftUI

struct LaunchableItemsViewContent<ItemType, ItemView>: View where ItemType: LaunchableItem, ItemView: View {
    // TODO: split into "items" and "onAction" (to make it cleaner + more reusable)
    @ObservedObject var viewModel: LaunchableItemsViewModel<ItemType>
    let addButtonText: String
    @ViewBuilder var itemView: (ItemType) -> ItemView

    @State private var hoveredItem: AppItem?

    var body: some View {
        VStack {
            EditableList(items: viewModel.items, addButtonText: addButtonText) { item in
                itemView(item)
            } onAddPressed: {
                viewModel.onAction(.addItemPressed)
            } onRemove: { item in
                viewModel.onAction(.removeItem(item: item))
            }
        }
    }
}
