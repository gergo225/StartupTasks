//
//  UrlPage.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 02.06.2024.
//

import Foundation
import SwiftUI

struct UrlsView: View {
    @StateObject var viewModel: UrlsViewModel = UrlsViewModel()

    @State private var urlString: String = ""

    var body: some View {
        UrlsViewContent(model: viewModel.urlPageModel, onAction: viewModel.onAction)
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

struct UrlsViewContent: View {
    @ObservedObject var model: UrlsPageModel
    var onAction: (UrlPageAction) -> Void = { _ in }

    @State private var hoveredItem: URL?

    var body: some View {
        VStack {
            EditableList(items: model.urlsToOpen, addButtonText: "Add new webpage") { url in
                UrlItemView(url: url)
            } onAddPressed: {
                onAction(.addUrlPressed)
            } onRemove: { url in
                onAction(.removeUrl(url: url))
            }
        }
    }
}

#Preview {
    let viewModel = UrlsViewModel()
    viewModel.urlPageModel.urlsToOpen = [
        URL(string: "https://typeracer.com")!,
        URL(string: "https://youtube.com")!
    ]
    return UrlsView(viewModel: viewModel)
}
