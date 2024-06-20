//
//  AppsPage.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 03.06.2024.
//

import Foundation
import SwiftUI

struct AppsView: View {
    @StateObject var viewModel: AppsViewModel = AppsViewModel()

    var body: some View {
        AppsViewContent(model: viewModel.model, onAction: viewModel.onAction)
            .sheet(isPresented: $viewModel.shouldPresentAppSelection) {
                appSelectionPage
            }
    }

    private var appSelectionPage: some View {
        AppSelectionPage { selectedApp in
            guard let selectedApp else { return }
            viewModel.onAction(.addApp(app: selectedApp))
        } onCancel: {
            viewModel.onAction(.cancelAddNewApp)
        }
    }
}

struct AppsViewContent: View {
    @ObservedObject var model: AppsPageModel
    var onAction: (AppsPageAction) -> Void = { _ in }

    @State private var hoveredItem: AppItem?

    var body: some View {
        VStack {
            DeleteableList(items: model.addedApps) { app in
                AppItemView(appItem: app)
            } onRemove: { app in
                onAction(.removeApp(app: app))
            }

            addNewAppsButton
        }
    }

    private var addNewAppsButton: some View {
        Button {
            onAction(.openAppSelectionList)
        } label: {
            HStack(alignment: .center) {
                Text(Strings.addNewApp)
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
    let viewModel = AppsViewModel()

    let safari = AppItem(appPath: URL(string: "/Applications/Safari.app")!)!
    let weather = AppItem(appPath: URL(string: "/System/Applications/Weather.app")!)!
    let apps = [safari, weather]
    viewModel.model.addedApps = apps

    return AppsView(viewModel: viewModel)
}
