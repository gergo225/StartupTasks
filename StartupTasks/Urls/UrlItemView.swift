//
//  UrlItemView.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 16.06.2024.
//

import SwiftUI

struct UrlItemView: View {
    let url: URL

    var body: some View {
        HStack(spacing: 8) {
            siteImage
                .frame(maxWidth: 32)

            Text(url.absoluteString)
        }
    }

    private var siteImage: some View {
        let imageUrl = URL(string: Favicon.getImageUrl(domainUrlString: url.absoluteString))
        return AsyncImage(url: imageUrl) { image in
            image.resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            ProgressView()
        }
    }
}

#Preview {
    UrlItemView(url: URL(string: "https://youtube.com")!)
        .padding()
}
