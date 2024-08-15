//
//  UrlPage.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 02.06.2024.
//

import Foundation
import SwiftUI

struct UrlsView: View {
    @ObservedObject var viewModel: UrlsViewModel

    @State private var urlString: String = ""

    var body: some View {
        LaunchableItemsViewContent(
            items: viewModel.items,
            onAction: viewModel.onAction,
            addButtonText: Strings.addNewWebpage
        ) { urlItem in
            UrlItemView(url: urlItem.path)
        }
        .sheet(isPresented: $viewModel.shouldPresentAddDialog) {
            addUrlPage
        }
    }

    private var addUrlPage: some View {
        AddUrlPage { urlString in
            viewModel.onAdd(urlString: urlString)
        } onCancel: {
            viewModel.onAction(.cancelAddNewItem)
        }
    }
}

#Preview {
    let urls = [
        URL(string: "https://typeracer.com")!,
        URL(string: "https://youtube.com")!
    ]
    let viewModel = UrlsViewModel(urls: urls)

    return UrlsView(viewModel: viewModel)
}
