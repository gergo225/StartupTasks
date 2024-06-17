//
//  UrlPage.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 02.06.2024.
//

import Foundation
import SwiftUI

struct UrlsPage: View {
    @StateObject var viewModel: UrlsViewModel = UrlsViewModel()

    @State private var urlString: String = ""

    var body: some View {
        UrlsPageContent(model: viewModel.urlPageModel, onAction: viewModel.onAction)
            .sheet(isPresented: $viewModel.shouldPresentAddUrl) {
               addUrlPage
            }
    }

    private var addUrlPage: some View {
        AddUrlPage { urlString in
            viewModel.onAction(.addUrl(urlString: urlString))
        } onCancel: {
            viewModel.onAction(.cancelAddNewUrl)
        }
    }
}

struct UrlsPageContent: View {
    @ObservedObject var model: UrlsPageModel
    var onAction: (UrlPageAction) -> Void = { _ in }

    @State private var hoveredItem: URL?

    var body: some View {
        VStack {
            DeleteableList(items: model.urlsToOpen) { url in
                UrlItemView(url: url)
            } onRemove: { url in
                onAction(.removeUrl(url: url))
            }

            addNewUrlButton
        }
        .padding()
    }

    private var addNewUrlButton: some View {
        Button {
            onAction(.openAddUrlPage)
        } label: {
            Label("Add new URL", systemImage: "plus")
        }
    }
}

#Preview {
    let viewModel = UrlsViewModel()
    viewModel.urlPageModel.urlsToOpen = [
        URL(string: "https://typeracer.com")!,
        URL(string: "https://youtube.com")!
    ]
    return UrlsPage(viewModel: viewModel)
}
