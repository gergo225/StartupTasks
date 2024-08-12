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
        FilesViewContent(model: viewModel.model, onAction: viewModel.onAction)
            .fileImporter(isPresented: $viewModel.shouldPresentFilePicker, allowedContentTypes: [.item]) { result in
                guard case .success(let filePath) = result else { return }
                viewModel.onAction(.addFile(filePath: filePath))
            }
    }
}

struct FilesViewContent: View {
    @ObservedObject var model: FilesPageModel
    var onAction: (FilesPageAction) -> Void = { _ in }

    @State private var hoveredItem: URL?

    var body: some View {
        VStack {
            EditableList(items: model.filePathsToOpen, addButtonText: "Add new file") { filePath in
                LaunchableItemView(item: FileItem(filePath: filePath))
            } onAddPressed: {
                onAction(.addFilePressed)
            } onRemove: { filePath in
                onAction(.removeFile(filePath: filePath))
            }
        }
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
