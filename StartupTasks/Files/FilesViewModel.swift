//
//  FilesViewModel.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 09.08.2024.
//

import Foundation

protocol FilesProfileDelegate: AnyObject {
    func addFileToProfile(filePath: URL)
    func removeFileFromProfile(filePath: URL)
}

enum FilesPageAction {
    case addFile(filePath: URL)
    case removeFile(filePath: URL)
    case addFilePressed
    case cancelAddNewFile
}

class FilesPageModel: ObservableObject {
    @Published var filePathsToOpen: [URL] = []
}

class FilesViewModel: ObservableObject {
    @Published var shouldPresentFilePicker: Bool = false
    @Published var model: FilesPageModel = FilesPageModel()

    weak var profileDelegate: FilesProfileDelegate?

    init(filePaths: [URL]) {
        let model = FilesPageModel()
        model.filePathsToOpen = filePaths
        self.model = model
    }

    func onAction(_ action: FilesPageAction) {
        switch action {
        case .addFile(let filePath):
            addFile(filePath: filePath)
            shouldPresentFilePicker = false
        case .removeFile(let filePath):
            removeFile(filePath: filePath)
        case .addFilePressed:
            shouldPresentFilePicker = true
        case .cancelAddNewFile:
            shouldPresentFilePicker = false
        }
    }
}

private extension FilesViewModel {
    func addFile(filePath: URL) {
        profileDelegate?.addFileToProfile(filePath: filePath)
    }

    func removeFile(filePath: URL) {
        profileDelegate?.removeFileFromProfile(filePath: filePath)
    }
}
