//
//  UrlPageViewModel.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 02.06.2024.
//

import Foundation
import SwiftUI

enum UrlPageAction {
    case addUrl(urlString: String)
    case removeUrl(url: URL)
    case openAddUrlPage
    case cancelAddNewUrl
}

class UrlsPageModel: ObservableObject {
    @Published var urlsToOpen: [URL] = LoginDefaults.standard.urlsToOpen
}

class UrlsViewModel: ObservableObject {
    @Published var shouldPresentAddUrl: Bool = false
    @ObservedObject var urlPageModel: UrlsPageModel = UrlsPageModel()

    func onAction(_ action: UrlPageAction) {
        switch action {
        case .addUrl(let urlString):
            addUrl(urlString: urlString)
            shouldPresentAddUrl = false
        case .removeUrl(let url):
            removeUrl(url)
        case .openAddUrlPage:
            shouldPresentAddUrl = true
        case .cancelAddNewUrl:
            shouldPresentAddUrl = false
        }
    }
}

private extension UrlsViewModel {
    private func addUrl(urlString: String) {
        guard let validUrl = URL(string: urlString) else { return }
        
        var urlsToOpen = LoginDefaults.standard.urlsToOpen
        urlsToOpen.append(validUrl)
        LoginDefaults.standard.urlsToOpen = urlsToOpen

        urlPageModel.urlsToOpen.append(validUrl)
    }

    private func removeUrl(_ url: URL) {
        var urlsToOpen = LoginDefaults.standard.urlsToOpen
        if let urlIndex = urlsToOpen.firstIndex(of: url) {
            urlsToOpen.remove(at: urlIndex)
            LoginDefaults.standard.urlsToOpen = urlsToOpen
        }

        if let urlIndex = urlPageModel.urlsToOpen.firstIndex(where: { $0 == url }) {
            urlPageModel.urlsToOpen.remove(at: urlIndex)
        }
    }
}
