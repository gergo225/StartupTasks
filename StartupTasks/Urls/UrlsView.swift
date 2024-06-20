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
            DeleteableList(items: model.urlsToOpen) { url in
                UrlItemView(url: url)
            } onRemove: { url in
                onAction(.removeUrl(url: url))
            }

            addNewUrlButton
        }
    }

    private var addNewUrlButton: some View {
        Button {
            onAction(.openAddUrlPage)
        } label: {
            HStack {
                Text("Add new URL")
                Spacer()
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                    .padding(8)
            }
            .padding(.vertical, 4)
            .contentShape(.buttonBorder)
        }
        .padding(.horizontal, 8)
        .buttonStyle(.plain)
        .foregroundStyle(.secondary)
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
