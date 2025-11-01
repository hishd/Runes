//
//  DebouncingTaskModifier.swift
//  Runes
//
//  Created by Michael Long on 11/1/25.
//

import SwiftUI

/// Adds a task modifier that executes only after a specified elapsed time.
/// ```
///    @State var text: String
///    var body: some View {
///        TextField("Search", text: $text)
///            .task(id: text, nanoseconds: 200_000_000 {
///                // do cancellable async task after 0.2s
///            }
///    }
/// ```
extension View {
    public func task<ID: Equatable>(
        id: ID,
        priority: TaskPriority = .userInitiated,
        nanoseconds: UInt64,
        task: @Sendable @escaping () async -> Void
    ) -> some View {
        modifier(
            DebouncingTaskModifier(id: id, priority: priority, nanoseconds: nanoseconds, task: task)
        )
    }
}

private struct DebouncingTaskModifier<ID: Equatable>: ViewModifier {
    let id: ID
    let priority: TaskPriority
    let nanoseconds: UInt64
    let task: @Sendable () async -> Void
    func body(content: Content) -> some View {
        content
            .task(id: id, priority: priority) {
                 do {
                    try await Task.sleep(nanoseconds: nanoseconds)
                    await task()
                } catch {
                    // ignore
                }
            }
    }
}

