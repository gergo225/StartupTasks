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
            Text(Strings.theseAppsWillOpen)
                .padding()

            List(model.addedApps, id: \.name) { appItem in
                appListItem(for: appItem)
            }

            addNewAppsButton
        }
        .padding(.vertical, 10)
    }

    private func appListItem(for app: AppItem) -> some View {
        let isHovered = hoveredItem == app

        return HStack {
            AppItemView(appItem: app)
            
            Spacer()

            Button {
                onAction(.removeApp(app: app))
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
                hoveredItem = hovering ? app : nil
            }
        }
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
