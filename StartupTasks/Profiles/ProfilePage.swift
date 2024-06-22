//
//  ProfilePage.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 19.06.2024.
//

import SwiftUI

struct ProfilePage: View {
    let profileViewModel: ProfileViewModel

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
        .frame(minWidth: 400, minHeight: 400, maxHeight: .infinity)
    }
}

#Preview {
    let appsViewModel = AppsViewModel()

    let safari = AppItem(appPath: URL(string: "/Applications/Safari.app")!)!
    let weather = AppItem(appPath: URL(string: "/System/Applications/Weather.app")!)!
    let apps = [safari, weather]
    appsViewModel.model.addedApps = apps

    let urlsViewModel = UrlsViewModel()
    urlsViewModel.urlPageModel.urlsToOpen = [
        URL(string: "https://typeracer.com")!,
        URL(string: "https://youtube.com")!
    ]

    let profileViewModel = ProfileViewModel(appsViewModel: appsViewModel, urlsViewModel: urlsViewModel)

    return ProfilePage(profileViewModel: profileViewModel)
        .frame(height: 800)
}
