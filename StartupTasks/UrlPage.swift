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
    
    var body: some View {
        VStack {
            urlInput

            Text(Strings.willOpenPage(pageUrl: model.addedUrlToOpen ?? Strings.emptyValue))
        }
        .padding()
    }

    private var urlInput: some View {
        Form {
            HStack {
                TextField(text: $urlString) {
                    Text(Strings.urlToAddInputLabel)
                }

                Button {
                    onAction(.submitUrl(urlString: urlString))
                } label: {
                    Text(Strings.saveLabel)
                }
            }
        }
    }
}

#Preview {
    let viewModel = UrlPageViewModel()
    viewModel.urlPageModel.addedUrlToOpen = "https://typeracer.com"
    return UrlPage(viewModel: viewModel)
}
