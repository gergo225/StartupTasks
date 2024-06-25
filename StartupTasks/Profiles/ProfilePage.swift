//
//  ProfilePage.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 19.06.2024.
//

import SwiftUI

struct ProfilePage: View {
    @ObservedObject var profileViewModel: ProfileViewModel

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                GroupBox {
                    AppsView(viewModel: profileViewModel.appsViewModel)
                } label: {
                    Text("Apps")
                }

                Spacer()
                    .frame(height: 16)

                GroupBox {
                    UrlsView(viewModel: profileViewModel.urlsViewModel)
                } label: {
                    Text("Websites")
                }
            }
            .groupBoxStyle(ListGroupBoxStyle())
            .padding()
        }
    }
}

#Preview {
    let safariPath = URL(string: "/Applications/Safari.app")!
    let weatherPath = URL(string: "/System/Applications/Weather.app")!
    let appPaths = [safariPath, weatherPath]

    let urls = [
        URL(string: "https://typeracer.com")!,
        URL(string: "https://youtube.com")!
    ]

    let profile = Profile(name: "Live Coding", apps: appPaths, urls: urls)
    let profileViewModel = ProfileViewModel(profile: profile)

    return ProfilePage(profileViewModel: profileViewModel)
        .frame(height: 800)
}
