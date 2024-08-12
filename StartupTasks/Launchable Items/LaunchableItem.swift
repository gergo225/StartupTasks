//
//  Launchable.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 11.08.2024.
//

import AppKit

protocol LaunchableItem: Hashable {
    var name: String { get }
    var icon: NSImage? { get }
    var path: URL { get }
}
