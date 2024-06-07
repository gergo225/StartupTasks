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

    var body: some View {
        AppsPageContent(model: viewModel.model, onAction: viewModel.onAction)
    }
}

struct AppsPageContent: View {
    @ObservedObject var model: AppsPageModel
    var onAction: (AppsPageAction) -> Void = { _ in }

    var body: some View {
        VStack {
            Text(Strings.selectAppsToOpen)
                .padding()

            List(model.addedApps, id: \.name) { appItem in
                AppItemView(appItem: appItem)
            }

            Button {
                // TODO: open dialog to add new apps
            } label: {
                Label("Add new app", systemImage: "plus")
            }
        }
        .padding(.vertical, 10)
    }
}


#Preview {
    let viewModel = AppsViewModel()

    let safari = AppItem(name: "Safari", icon: AppUtils.getIconForApp(named: "Safari"))
    let weather = AppItem(name: "Weather", icon: AppUtils.getIconForApp(named: "Weather"))
    let apps = [safari, weather]
    viewModel.model.addedApps = apps

    return AppsPage(viewModel: viewModel)
        .frame(minWidth: 400, minHeight: 250)
}
