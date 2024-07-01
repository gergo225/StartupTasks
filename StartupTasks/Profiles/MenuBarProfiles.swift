//
//  MenuBarProfiles.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 30.06.2024.
//

import SwiftUI
import MenuBarExtraAccess

struct MenuBarProfiles: View {
    @StateObject private var viewModel = MenuBarProfilesViewModel()

    var body: some View {
        MenuBarProfilesContent(profiles: viewModel.profiles, onSelected: viewModel.onProfileSelected)
    }
}

struct MenuBarProfilesContent: View {
    let profiles: [Profile]
    var onSelected: (Profile) -> Void

    @State private var hovered: Profile?

    var body: some View {
        VStack(spacing: 4) {
            ForEach(profiles) { profile in
                profileItem(for: profile)
                    .onHover {
                        if $0 {
                            hovered = profile
                        } else {
                            hovered = nil
                        }
                    }
            }
        }
        .padding(.vertical, 4)
        .frame(minWidth: 100, maxWidth: 200)
    }

    private func profileItem(for profile: Profile) -> some View {
        let isHovered = hovered == profile

        return Button {
            onSelected(profile)
        } label: {
            Label(profile.name, systemImage: "play")
        }
        .buttonStyle(MenuBarButtonStyle(isHovered: isHovered))
    }
}

struct MenuBarButtonStyle: ButtonStyle {
    let isHovered: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(8)
            .background(configuration.isPressed ? .blue : isHovered ? .black.opacity(0.3) : .clear)
            .clipShape(.rect(cornerRadius: 4))
            .padding(.horizontal, 4)
    }
}

#Preview {
    let profiles = [
        Profile(name: "First", apps: [], urls: []),
        Profile(name: "Second", apps: [], urls: [])
    ]

    return MenuBarProfilesContent(profiles: profiles) { _ in }
}
