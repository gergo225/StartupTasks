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
                guard shouldPresent else { return }
                isAppSelectionSheetPresented = true
            }
    }

    private var appSelectionPage: some View {
        AppSelectionPage { selectedApp in
            guard let selectedApp else { return }
            viewModel.onAction(.addNewApp(app: selectedApp))
            isAppSelectionSheetPresented = false
        } onCancel: {
            isAppSelectionSheetPresented = false
        }
    }
}

struct AppsPageContent: View {
    @ObservedObject var model: AppsPageModel
    var onAction: (AppsPageAction) -> Void = { _ in }

    var body: some View {
        VStack {
            Text(Strings.theseAppsWillOpen)
                .padding()

            List(model.addedApps, id: \.name) { appItem in
                AppItemView(appItem: appItem)
            }

            Button {
                onAction(.openAppSelectionList)
            } label: {
                Label(Strings.addNewApp, systemImage: "plus")
            }
        }
        .padding(.vertical, 10)
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
