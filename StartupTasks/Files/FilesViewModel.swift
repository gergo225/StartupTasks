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

class FilesViewModel: LaunchableItemsViewModel<FileItem> {
    weak var profileDelegate: FilesProfileDelegate?

    init(filePaths: [URL]) {
        super.init(items: filePaths.map { FileItem(filePath: $0) })
    }

    override func addItem(_ item: FileItem) {
        profileDelegate?.addFileToProfile(filePath: item.path)
    }

    override func removeItem(_ item: FileItem) {
        profileDelegate?.removeFileFromProfile(filePath: item.path)
    }
}
