//
//  AppsPage.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 03.06.2024.
//

import Foundation
import SwiftUI

struct AppsPage: View {
    @StateObject var viewModel: AppsViewModel = AppsViewModel()

    @State private var isAppSelectionSheetPresented: Bool = false

    var body: some View {
        AppsPageContent(model: viewModel.model, onAction: viewModel.onAction)
            .sheet(isPresented: $isAppSelectionSheetPresented) {
                appSelectionPage
            }
            .onChange(of: viewModel.shouldPresentAppSelection) { _, shouldPresent in
                isAppSelectionSheetPresented = shouldPresent
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

struct AppsPageContent: View {
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
        .padding(.vertical, 10)
    }

    private var addNewAppsButton: some View {
        Button {
            onAction(.openAppSelectionList)
        } label: {
            Label(Strings.addNewApp, systemImage: "plus")
        }
    }
}


#Preview {
    let viewModel = AppsViewModel()

    let safari = AppItem(appPath: URL(string: "/Applications/Safari.app")!)!
    let weather = AppItem(appPath: URL(string: "/System/Applications/Weather.app")!)!
    let apps = [safari, weather]
    viewModel.model.addedApps = apps

    return AppsPage(viewModel: viewModel)
        .frame(minWidth: 400, minHeight: 250)
}
