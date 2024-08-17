//
//  TextInputPrompt.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 26.06.2024.
//

import SwiftUI

struct TextInputPrompt: View {
    @State private var inputString: String = ""

    var onConfirm: (String) -> Void
    var onCancel: () -> Void
    var cancelButtonString: String = Strings.cancelLabel
    var confirmButtonString: String = Strings.confirmLabel
    var textPrompt: String = ""

    var body: some View {
        VStack {
            Spacer()
            urlInput
            Spacer()
            buttonRow
        }
        .onKeyPress(.return) {
            if !inputString.trimmingCharacters(in: .whitespaces).isEmpty {
                DispatchQueue.main.async {
                    onConfirm(inputString)
                }
                return .handled
            } else {
                return .ignored
            }
        }
        .padding()
        .frame(minWidth: 350, maxWidth: 600, minHeight: 100, maxHeight: 150)
    }

    private var urlInput: some View {
        TextField(text: $inputString) {
            Text(textPrompt)
        }
    }

    private var buttonRow: some View {
        HStack {
            Spacer()

            Button(role: .cancel, action: onCancel) {
                Text(cancelButtonString)
            }

            Button {
                if !inputString.trimmingCharacters(in: .whitespaces).isEmpty {
                    onConfirm(inputString)
                }
            } label: {
                Text(confirmButtonString)
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    TextInputPrompt(onConfirm: { url in

    }, onCancel: {

    }, textPrompt: "Enter text here")
}

