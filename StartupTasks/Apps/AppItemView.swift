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
            Image(nsImage: appItem.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)

            Text(appItem.name)
        }
    }
}

#Preview {
    let systemApp = AppItem(appPath: URL(string: "/System/Applications/FindMy.app")!)!
    let userApp = AppItem(appPath: URL(string: "/Applications/Google Chrome.app")!)!

    return VStack(alignment: .leading) {
        AppItemView(appItem: systemApp)
        AppItemView(appItem: userApp)
    }
    .padding()
}
