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
        case profiles = "profiles"
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
