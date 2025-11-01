//
//  Publisher+async.swift
//  Runes
//
//  Created by Michael Long on 4/10/24.
//

import Combine
import SwiftUI

extension Publisher where Output: Sendable {
    /// Converts Combine publisher to async/await function
    /// ```swift
    ///    let name = try? await Just("Hello Combine!")
    ///        .delay(for: .seconds(3), scheduler: RunLoop.main)
    ///        .async()
    ///    print(name)
    ///    ```
    public func async() async throws -> Output {
        try await withCheckedThrowingContinuation { continuation in
            var cancellable: AnyCancellable?
            cancellable = self.sink {
                switch $0 {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .finished:
                    cancellable?.cancel()
                }
            } receiveValue: {
                continuation.resume(returning: $0)
            }
        }
    }
}
