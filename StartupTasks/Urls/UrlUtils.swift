//
//  UrlUtils.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 29.06.2024.
//

import Foundation

extension URL {
    var withHttp: URL {
        let urlString = absoluteString
        if urlString.starts(with: "http://") || urlString.starts(with: "https://") {
            return self
        }

        guard let urlWithHttp = URL(string: "http://\(urlString)") else  { return self }
        return urlWithHttp
    }
}
