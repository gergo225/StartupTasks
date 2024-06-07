//
//  AppItemView.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 04.06.2024.
//

import Foundation
import SwiftUI

struct AppItemView: View {
    let appItem: AppItem

    var body: some View {
        HStack(spacing: 8) {
            if let appIcon = appItem.icon {
                Image(nsImage: appIcon)
            } else {
                Image(systemName: "xmark.circle.fill")
            }

            Text(appItem.name)
        }
    }
}

#Preview {
    let systemApp = getAppItem(named: "FindMy")
    let userApp = getAppItem(named: "Google Chrome")

    return VStack(alignment: .leading) {
        AppItemView(appItem: systemApp)
        AppItemView(appItem: userApp)
    }
    .padding()

    func getAppItem(named appName: String) -> AppItem {
        let appIcon = AppUtils.getIconForApp(named: appName)
        return AppItem(name: appName, icon: appIcon)
    }
}
