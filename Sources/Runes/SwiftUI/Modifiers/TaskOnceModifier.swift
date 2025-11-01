//
//  View+task.swift
//  Runes
//
//  Created by Michael Long on 11/27/23.
//

import Combine
import SwiftUI

/// Adds a task modifier that's executed one time only.
/// ```
///    var body: some View {
///        Text("Hello")
///            .taskOnce {
///                // do async task one time only
///            }
///    }
/// ```
extension View {
    public func taskOnce(perform action: @Sendable @escaping () async -> Void) -> some View {
        modifier(TaskOnceModifier(action: action))
    }
}

private struct TaskOnceModifier: ViewModifier {
    let action: @Sendable () async -> Void
    @State private var performAction = true
    func body(content: Content) -> some View {
        content.task {
            if performAction {
                performAction = false
                await action()
            }
        }
    }
}
