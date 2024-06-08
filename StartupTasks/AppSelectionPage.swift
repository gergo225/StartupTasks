//
//  AppSelectionPage.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 08.06.2024.
//

import Foundation
import SwiftUI

struct AppSelectionPage: View {
    @State private var selectedApp: AppItem?

    var onConfirm: (AppItem?) -> Void
    var onCancel: () -> Void

    var body: some View {
        VStack {
            AppsList(selectedApp: $selectedApp)

            buttonRow
        }
        .padding()
        .frame(minWidth: 500, minHeight: 400)
    }

    private var buttonRow: some View {
        HStack {
            Spacer()

            Button(role: .cancel, action: onCancel) {
                Text(Strings.cancelLabel)
            }

            Button {
                onConfirm(selectedApp)
            } label: {
                Text(Strings.addLabel)
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    AppSelectionPage(onConfirm: { _ in }, onCancel: { })
}
