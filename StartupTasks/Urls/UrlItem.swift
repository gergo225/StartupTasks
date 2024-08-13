//
//  UrlItem.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 12.08.2024.
//

import AppKit

class UrlItem: LaunchableItem {
    static func == (lhs: UrlItem, rhs: UrlItem) -> Bool {
        lhs.path == rhs.path
    }
    
    init(url: URL) {
        path = url
    }

    var name: String {
        path.absoluteString
    }

    var icon: NSImage? = nil

    var path: URL

    func hash(into hasher: inout Hasher) {
        hasher.combine(path)
    }
}
