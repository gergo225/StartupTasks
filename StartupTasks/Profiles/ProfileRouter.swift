//
//  ProfileRouter.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 25.06.2024.
//

import SwiftUI

class ProfileRouter {
    static func profilePage(for profile: Profile) -> some View {
        let viewModel = ProfileViewModel(profile: profile)
        return ProfilePage(profileViewModel: viewModel)
    }
}
