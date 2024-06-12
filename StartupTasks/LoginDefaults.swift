//
//  LoginDefaults.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 29.05.2024.
//

import Foundation
import Combine

final class LoginDefaults: NSObject {
    static let standard = LoginDefaults(userDefaults: .standard)

    private static var context = 0

    private enum Keys: String, CaseIterable {
        case launchedAfterLogin = "launchedAfterLogin"
        case finishedStartupProcess = "finishedStartupProcess"
        case urlToOpen = "urlToOpen"
        case appsPathsToOpen = "appPathsToOpen"
    }

    private let changedInput: PassthroughSubject<LoginDefaults, Never>
    let changed: AnyPublisher<LoginDefaults, Never>

    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults

        changedInput = PassthroughSubject<LoginDefaults, Never>()
        changed = changedInput.shareLatest()

        super.init()

        for key in Keys.allCases {
            userDefaults.addObserver(self, forKeyPath: key.rawValue, options: [], context: &LoginDefaults.context)
        }
    }

    deinit {
        for key in Keys.allCases {
            userDefaults.removeObserver(self, forKeyPath: key.rawValue, context: &LoginDefaults.context)
        }
    }

    var launchedAtLogin: Bool {
        set {
            userDefaults.set(newValue, forKey: Keys.launchedAfterLogin.rawValue)
        }
        get {
            userDefaults.value(forKey: Keys.launchedAfterLogin.rawValue) as? Bool ?? false
        }
    }

    var finishedStartupProcess: Bool {
        set {
            userDefaults.set(newValue, forKey: Keys.finishedStartupProcess.rawValue)
        }
        get {
            userDefaults.value(forKey: Keys.finishedStartupProcess.rawValue) as? Bool ?? false
        }
    }

    var urlsToOpen: [URL] {
        set {
            let urlStrings = newValue.map { $0.absoluteString }
            userDefaults.set(urlStrings, forKey: Keys.urlToOpen.rawValue)
        }
        get {
            let urlStrings = userDefaults.value(forKey: Keys.urlToOpen.rawValue) as? [String] ?? []
            return urlStrings.compactMap { URL(string: $0) }
        }
    }

    var appPathsToOpen: [URL] {
        set {
            let appPathStrings = newValue.map { $0.absoluteString }
            userDefaults.set(appPathStrings, forKey: Keys.appsPathsToOpen.rawValue)
        }
        get {
            let appPathStrings = userDefaults.value(forKey: Keys.appsPathsToOpen.rawValue) as? [String] ?? []
            return appPathStrings.compactMap { URL(string: $0) }
        }
    }
}

extension LoginDefaults {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard context == &LoginDefaults.context else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }

        changedInput.send(self)
    }
}
