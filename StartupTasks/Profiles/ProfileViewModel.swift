//
//  ProfileViewModel.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 22.06.2024.
//

import Foundation
import AppKit

class ProfileViewModel: ObservableObject {
    let appsViewModel: AppsViewModel
    let urlsViewModel: UrlsViewModel

    init(appsViewModel: AppsViewModel, urlsViewModel: UrlsViewModel) {
        self.appsViewModel = appsViewModel
        self.urlsViewModel = urlsViewModel
    }
}
