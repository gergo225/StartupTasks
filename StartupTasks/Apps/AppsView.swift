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
        LaunchableItemsViewContent(
            items: viewModel.items,
            onAction: viewModel.onAction,
            addButtonText: Strings.addNewApp
        ) { appItem in
            LaunchableItemView(item: appItem)
        }
        .sheet(isPresented: $viewModel.shouldPresentAddDialog) {
            appSelectionPage
        }
    }

    private var appSelectionPage: some View {
        AppSelectionPage { selectedApp in
            guard let selectedApp else { return }
            viewModel.onAction(.addItem(item: selectedApp))
        } onCancel: {
            viewModel.onAction(.cancelAddNewItem)
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
