//
//  FilesView.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 09.08.2024.
//

import SwiftUI

struct FilesView: View {
    @ObservedObject var viewModel: FilesViewModel

    var body: some View {
        LaunchableItemsViewContent(
            items: viewModel.items,
            onAction: viewModel.onAction,
            addButtonText: Strings.addNewFile
        ) { fileItem in
            LaunchableItemView(item: fileItem)
        }
        .fileImporter(
            isPresented: $viewModel.shouldPresentAddDialog,
            allowedContentTypes: [.item],
            onCompletion: { result in
                guard case .success(let filePath) = result else { return }
                viewModel.onAction(.addItem(item: FileItem(filePath: filePath)))
            }
        )
    }
}

#Preview {
    let filePaths = [
        URL(string: "/Users/fazekasgergo/Music/Music/Music Library.musiclibrary")!,
        URL(string: "/Users/fazekasgergo/Music/Music")!
    ]
    let viewModel = FilesViewModel(filePaths: filePaths)

    return FilesView(viewModel: viewModel)
}
