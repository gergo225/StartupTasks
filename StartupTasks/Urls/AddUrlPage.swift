//
//  AddUrlPage.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 16.06.2024.
//

import SwiftUI

struct AddUrlPage: View {
    @State private var urlString: String = ""

    var onConfirm: (String) -> Void
    var onCancel: () -> Void

    var body: some View {
        VStack {
            Spacer()
            urlInput
            Spacer()
            buttonRow
        }
        .padding()
        .frame(minWidth: 350, maxWidth: 600, minHeight: 100, maxHeight: 150)
    }

    private var urlInput: some View {
        TextField(text: $urlString) {
            Text("URL to open")
        }
    }

    private var buttonRow: some View {
        HStack {
            Spacer()

            Button(role: .cancel, action: onCancel) {
                Text(Strings.cancelLabel)
            }

            Button {
                onConfirm(urlString)
            } label: {
                Text(Strings.addLabel)
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    AddUrlPage(onConfirm: { url in

    }, onCancel: {

    })
}
