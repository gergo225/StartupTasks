//
//  CombineExtensions.swift
//  StartupTasks
//
//  Created by Fazekas, Gergo on 31.05.2024.
//

import Foundation
import Combine

extension Publisher {
    func shareLatest() -> AnyPublisher<Output, Failure> {
        self
            .map { Optional($0) }
            .multicast(subject: CurrentValueSubject(nil))
            .autoconnect()
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
}
