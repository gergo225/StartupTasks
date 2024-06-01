//
//  ContentView.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 25.05.2024.
//

import SwiftUI
import LaunchAtLogin

struct MainView: View {
    @StateObject var viewModel: MainViewModel = MainViewModel()

    var body: some View {
        MainViewContent(model: viewModel.mainModel, onAction: viewModel.onAction)
    }
}

struct MainViewContent: View {
    @ObservedObject var model: MainModel
    var onAction: (MainAction) -> Void = { _ in }

    @State private var launchedAtLogin: Bool? = nil
    @State private var urlString: String = ""

    var body: some View {
        VStack(spacing: 16) {
            Text(Strings.openSettingsToChange)

            urlInput

            Text(Strings.willOpenPage(pageUrl: model.addedUrlToOpen ?? Strings.emptyValue))
        }
        .padding()
        .onAppear {
            launchedAtLogin = LoginDefaults.standard.launchedAtLogin
        }
        .onChange(of: launchedAtLogin) {
            guard let launchedAtLogin else { return }
            onAction(.launchedAtLoginChanged(launchedAtLogin: launchedAtLogin))
        }
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
    let viewModel = MainViewModel()
    viewModel.mainModel.addedUrlToOpen = "https://play.typeracer.com"
    return MainView(viewModel: viewModel)
}
