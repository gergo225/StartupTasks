//
//  AppsList.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 29.05.2024.
//

import Foundation
import SwiftUI

struct AppsList: View {
    @Binding var selectedApp: AppItem?

    private let allApps = AppUtils.getAllAppPaths().compactMap {
        AppItem(appPath: $0)
    }.sorted(by: { $0.name < $1.name })

    var body: some View {
        List(allApps, id: \.self, selection: $selectedApp) { app in
            appItem(app: app)
        }
    }

    private func appItem(app: AppItem) -> some View {
        HStack(spacing: 8) {
            if let icon = app.icon {
                Image(nsImage: icon)
            } else {
                Image(systemName: "xmark.circle.fill")
            }

            Text(app.name)
        }
    }
}

#Preview {
    @State var selectedApp: AppItem?
    return AppsList(selectedApp: $selectedApp)
}
