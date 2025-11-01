//
//  DelayModifier.swift
//  Runes
//
//  Created by Michael Long on 9/15/25.
//

import SwiftUI

extension View {
    public func onDelay(_ seconds: TimeInterval, perform action: @escaping () -> Void) -> some View {
        self.modifier(DelayModifier(delay: seconds, action: action))
    }
}

private struct DelayModifier: ViewModifier {
    let delay: TimeInterval
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .task {
                do {
                    try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000.0))
                    action()
                } catch {
                    // cancelled
                }
            }
    }
}
