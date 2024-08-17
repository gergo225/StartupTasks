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
                    Text(Strings.appsLabel)
                }

                Spacer()
                    .frame(height: 16)

                GroupBox {
                    UrlsView(viewModel: profileViewModel.urlsViewModel)
                } label: {
                    Text(Strings.websitesLabel)
                }

                Spacer()
                    .frame(height: 16)

                GroupBox {
                    FilesView(viewModel: profileViewModel.filesViewModel)
                } label: {
                    Text(Strings.filesLabel)
                }
            }
            .groupBoxStyle(ListGroupBoxStyle())
            .padding()
        }
    }
}

#Preview {
    //TODO: app paths crash Preview - why?
    let safariPath = URL(string: "/Applications/Safari.app")!
    let weatherPath = URL(string: "/System/Applications/Weather.app")!
    let appPaths = [safariPath, weatherPath]

    let urls = [
        URL(string: "https://typeracer.com")!,
        URL(string: "https://youtube.com")!
    ]

    let filePaths = [
        URL(string: "/Users/fazekasgergo/Music/Music/Music Library.musiclibrary")!,
        URL(string: "/Users/fazekasgergo/Music/Music/")!
    ]

    let profile = Profile(name: "Live Coding", apps: appPaths, urls: urls, filePaths: filePaths)
    let profileViewModel = ProfileViewModel(profile: profile)

    return ProfilePage(profileViewModel: profileViewModel)
        .frame(height: 800)
}
