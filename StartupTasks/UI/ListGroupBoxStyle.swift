//
//  ListGroupBoxStyle.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 20.06.2024.
//

import SwiftUI

struct ListGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            configuration.label
                .font(.headline)

            configuration.content
                .padding(.vertical, 8)
                .background(.background)
                .clipShape(.rect(cornerRadius: 8))
        }
    }
}
