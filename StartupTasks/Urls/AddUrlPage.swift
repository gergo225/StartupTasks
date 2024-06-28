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
        TextInputPrompt(
            onConfirm: onConfirm,
            onCancel: onCancel,
            confirmButtonString: Strings.addLabel,
            textPrompt: "Website to open"
        )
    }
}

#Preview {
    AddUrlPage(onConfirm: { url in

    }, onCancel: {

    })
}
