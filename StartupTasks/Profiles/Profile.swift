//
//  Profile.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 23.06.2024.
//

import Foundation

struct Profile: Hashable, Identifiable {
    var id: UUID
    var name: String
    var apps: [AppItem]
    var urls: [URL]
}

extension Profile {
    init(name: String, apps: [URL], urls: [URL]) {
        self.id = UUID()
        self.name = name
        self.apps = apps.compactMap { AppItem(appPath: $0) }
        self.urls = urls
    }
}

extension Profile: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(type(of: id), forKey: .id)
        self.name = try container.decode(type(of: name), forKey: .name)

        let appPathStrings = try container.decode([String].self, forKey: .apps)
        let appPaths = appPathStrings.compactMap { URL(string: $0) }
        self.apps = appPaths.compactMap { AppItem(appPath: $0) }

        let urlStrings = try container.decode([String].self, forKey: .urls)
        self.urls = urlStrings.compactMap { URL(string: $0) }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(apps.map { $0.appPath.absoluteString }, forKey: .apps)
        try container.encode(urls.map { $0.absoluteString }, forKey: .urls)
    }

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case apps = "appPaths"
        case urls = "urls"
    }
}
