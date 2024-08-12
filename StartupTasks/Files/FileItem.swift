//
//  FileItem.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 11.08.2024.
//

import AppKit

class FileItem: LaunchableItem {
    var path: URL

    init(filePath: URL) {
        self.path = filePath
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(path)
    }

    static func == (lhs: FileItem, rhs: FileItem) -> Bool {
        lhs.hashValue == rhs.hashValue
    }

    var name: String {
        path.relativePath
    }

    var icon: NSImage? {
        NSWorkspace.shared.icon(forFile: path.relativePath)
    }
}
