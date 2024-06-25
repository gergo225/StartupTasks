//
//  AppsPage.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 03.06.2024.
//

import Foundation
import SwiftUI

struct AppsView: View {
    @ObservedObject var viewModel: AppsViewModel

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
            EditableList(items: model.addedApps, addButtonText: Strings.addNewApp) { app in
                AppItemView(appItem: app)
            } onAddPressed: {
                onAction(.addAppPressed)
            } onRemove: { app in
                onAction(.removeApp(app: app))
            }
        }
    }

}

#Preview {
    let safari = AppItem(appPath: URL(string: "/Applications/Safari.app")!)!
    let weather = AppItem(appPath: URL(string: "/System/Applications/Weather.app")!)!
    let apps = [safari, weather]

    let viewModel = AppsViewModel(apps: apps)

    return AppsView(viewModel: viewModel)
}
