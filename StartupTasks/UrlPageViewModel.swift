//
//  UrlPageViewModel.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 02.06.2024.
//

import Foundation
import SwiftUI

enum UrlPageAction {
    case submitUrl(urlString: String)
}

class UrlPageModel: ObservableObject {
    @Published var addedUrlToOpen: String? = LoginDefaults.standard.urlToOpen
}

class UrlPageViewModel: ObservableObject {
    @ObservedObject var urlPageModel: UrlPageModel = UrlPageModel()

    func onAction(_ action: UrlPageAction) {
        switch action {
        case .submitUrl(let urlString):
            submitUrl(urlString: urlString)
        }
    }
}

private extension UrlPageViewModel {
    private func submitUrl(urlString: String) {
        guard let validUrl = URL(string: urlString) else { return }
        LoginDefaults.standard.urlToOpen = validUrl.absoluteString
        urlPageModel.addedUrlToOpen = validUrl.absoluteString
    }
}
