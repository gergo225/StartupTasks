//
//  UrlPageViewModel.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 02.06.2024.
//

import Foundation
import SwiftUI

protocol UrlsProfileDelegate: AnyObject {
    func addUrlToProfile(url: URL)
    func removeUrlFromProfile(url: URL)
}

class UrlsViewModel: LaunchableItemsViewModel<UrlItem> {
    weak var profileDelegate: UrlsProfileDelegate?

    init(urls: [URL]) {
        super.init(items: urls.map { UrlItem(url: $0) })
    }

    override func addItem(_ item: UrlItem) {
        profileDelegate?.addUrlToProfile(url: item.path)
    }

    override func removeItem(_ item: UrlItem) {
        profileDelegate?.removeUrlFromProfile(url: item.path)
    }

    func onAdd(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        onAction(.addItem(item: UrlItem(url: url)))
    }
}
