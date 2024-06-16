//
//  DeleteableList.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 16.06.2024.
//

import SwiftUI

struct DeleteableList<Value, Content>: View where Value: Hashable, Content: View {

    let items: [Value]
    @ViewBuilder var itemContent: (Value) -> Content
    var onRemove: (Value) -> Void

    @State private var hoveredItem: Value?

    var body: some View {
            List(items, id: \.self) { item in
                itemView(for: item)
            }
    }

    private func itemView(for item: Value) -> some View {
        let isHovered = hoveredItem == item

        return HStack {
            itemContent(item)

            Spacer()

            Button {
                onRemove(item)
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 12)
                    .foregroundStyle(.secondary)
                    .padding(8)
                    .background(isHovered ? .red : Color(.clear))
                    .clipShape(.rect(cornerRadius: 8))
            }
            .buttonStyle(.plain)
            .onHover { hovering in
                hoveredItem = hovering ? item : nil
            }
        }
    }
}
