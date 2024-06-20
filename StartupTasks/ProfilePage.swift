//
//  ProfilePage.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 19.06.2024.
//

import SwiftUI

struct ProfilePage: View {

    @ObservedObject var appsViewModel: AppsViewModel = AppsViewModel()
    @ObservedObject var urlsViewModel: UrlsViewModel = UrlsViewModel()

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                GroupBox {
                    AppsView(viewModel: appsViewModel)
                } label: {
                    Text("Apps")
                }

                Spacer()
                    .frame(height: 16)

                GroupBox {
                    UrlsView(viewModel: urlsViewModel)
                } label: {
                    Text("Websites")
                }
            }
            .groupBoxStyle(ListGroupBoxStyle())
            .padding()
        }
        .frame(maxHeight: .infinity)
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

    return ProfilePage(appsViewModel: appsViewModel, urlsViewModel: urlsViewModel)
        .frame(height: 800)
}
