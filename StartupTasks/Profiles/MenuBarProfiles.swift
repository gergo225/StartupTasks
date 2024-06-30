//
//  MenuBarProfiles.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 30.06.2024.
//

import SwiftUI
import MenuBarExtraAccess

struct MenuBarProfiles: Scene {
    @StateObject private var viewModel = MenuBarProfilesViewModel()
    @State private var isMenuBarPresented = false

    var body: some Scene {
        MenuBarExtra("Startup Profiles") {
            MenuBarProfilesContent(profiles: viewModel.profiles) {
                viewModel.onProfileSelected($0)
                isMenuBarPresented = false
            }
        }
        // TODO: fix: profiles get updated in VM, but not in View
        .onChange(of: viewModel.profiles) { _, newValue in
            print("mylog - profiles: \(newValue.count)")
        }
        .menuBarExtraStyle(.window)
        .menuBarExtraAccess(isPresented: $isMenuBarPresented)
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
            .background(configuration.isPressed ? .blue : isHovered ? Color.secondary : .clear)
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
