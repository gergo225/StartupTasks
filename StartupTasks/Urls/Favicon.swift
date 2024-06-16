//
//  Favicon.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 16.06.2024.
//

import Foundation

struct Favicon {
    static func getImageUrl(domainUrlString: String) -> String {
        let size = 128
        return "https://www.google.com/s2/favicons?sz=\(size)&domain=\(domainUrlString)"
    }
}
