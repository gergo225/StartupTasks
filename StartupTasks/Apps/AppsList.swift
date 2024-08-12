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
            LaunchableItemView(item: app)
        }
    }
}

#Preview {
    @State var selectedApp: AppItem?
    return AppsList(selectedApp: $selectedApp)
}
