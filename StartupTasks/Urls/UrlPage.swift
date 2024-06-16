//
//  UrlPage.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 02.06.2024.
//

import Foundation
import SwiftUI

struct UrlPage: View {
    @StateObject var viewModel: UrlPageViewModel = UrlPageViewModel()

    var body: some View {
        UrlPageContent(model: viewModel.urlPageModel, onAction: viewModel.onAction)
    }
}

struct UrlPageContent: View {
    @ObservedObject var model: UrlPageModel
    var onAction: (UrlPageAction) -> Void = { _ in }

    @State private var urlString: String = ""
    @State private var hoveredItem: URL?

    var body: some View {
        VStack {
            List(model.urlsToOpen, id: \.self) { url in
                urlItem(for: url)
            }

            urlInput
        }
        .padding()
    }

    private func urlItem(for url: URL) -> some View {
        let isHovered = hoveredItem == url

        return HStack {
            Text(url.absoluteString)

            Spacer()

            Button {
                onAction(.removeUrl(url: url))
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 12)
                    .foregroundStyle(.secondary)
                    .padding(8)
                    .background(isHovered ? .red : Color(.clear))
                    .clipShape(.rect(cornerRadius: 8))
            }
            .buttonStyle(.plain)
            .onHover { hovering in
                hoveredItem = hovering ? url : nil
            }
        }
    }

    private var urlInput: some View {
        Form {
            HStack {
                TextField(text: $urlString) {
                    Text(Strings.urlToAddInputLabel)
                }

                Button {
                    onAction(.addUrl(urlString: urlString))
                } label: {
                    Text(Strings.addLabel)
                }
            }
        }
    }
}

#Preview {
    let viewModel = UrlPageViewModel()
    viewModel.urlPageModel.urlsToOpen = [
        URL(string: "https://typeracer.com")!,
        URL(string: "https://youtube.com")!
    ]
    return UrlPage(viewModel: viewModel)
}
