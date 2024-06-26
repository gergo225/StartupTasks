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

enum UrlPageAction {
    case addUrl(urlString: String)
    case removeUrl(url: URL)
    case addUrlPressed
    case cancelAddNewUrl
}

class UrlsPageModel: ObservableObject {
    @Published var urlsToOpen: [URL] = []
}

class UrlsViewModel: ObservableObject {
    @Published var shouldPresentAddUrl: Bool = false
    @Published var model: UrlsPageModel = UrlsPageModel()

    weak var profileDelegate: UrlsProfileDelegate?

    init(urls: [URL]) {
        let model = UrlsPageModel()
        model.urlsToOpen = urls
        self.model = model
    }

    func onAction(_ action: UrlPageAction) {
        switch action {
        case .addUrl(let urlString):
            addUrl(urlString: urlString)
            shouldPresentAddUrl = false
        case .removeUrl(let url):
            removeUrl(url)
        case .addUrlPressed:
            shouldPresentAddUrl = true
        case .cancelAddNewUrl:
            shouldPresentAddUrl = false
        }
    }
}

private extension UrlsViewModel {
    private func addUrl(urlString: String) {
        guard let validUrl = URL(string: urlString) else { return }
        
        profileDelegate?.addUrlToProfile(url: validUrl)
    }

    private func removeUrl(_ url: URL) {
        profileDelegate?.removeUrlFromProfile(url: url)
    }
}
