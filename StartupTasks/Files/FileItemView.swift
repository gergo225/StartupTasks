//
//  FileItemView.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 10.08.2024.
//

import SwiftUI

struct FileItemView: View {
    let filePath: URL

    var body: some View {
        HStack(spacing: 8) {
            fileImage
                .frame(width: 40, height: 40)

            Text(filePath.relativePath)
        }
    }

    private var fileImage: some View {
        let fileIcon = NSWorkspace.shared.icon(forFile: filePath.relativePath)

        return Image(nsImage: fileIcon)
            .resizable()
            .scaledToFit()
    }
}

#Preview {
    let musicFilePath = URL(string: "/Users/fazekasgergo/Music/Music/Music Library.musiclibrary")!
    let musicFolderPath = URL(string: "/Users/fazekasgergo/Music/Music/")!

    return VStack(alignment: .leading) {
        FileItemView(filePath: musicFilePath)
        FileItemView(filePath: musicFolderPath)
    }
    .padding()
}
