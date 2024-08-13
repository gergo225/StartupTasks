//
//  AppItemView.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 04.06.2024.
//

import Foundation
import SwiftUI

struct LaunchableItemView: View {
    let item: any LaunchableItem

    var body: some View {
        HStack(spacing: 8) {
            if let icon = item.icon {
                Image(nsImage: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }

            Text(item.name)
        }
    }
}

#Preview {
    let systemApp = AppItem(appPath: URL(string: "/System/Applications/FindMy.app")!)!
    let userApp = AppItem(appPath: URL(string: "/Applications/Google Chrome.app")!)!

    return VStack(alignment: .leading) {
        LaunchableItemView(item: systemApp)
        LaunchableItemView(item: userApp)
    }
    .padding()
}
