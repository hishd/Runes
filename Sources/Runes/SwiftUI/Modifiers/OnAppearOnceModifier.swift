//
//  View+onAppearOnce.swift
//  Runes
//
//  Created by Michael Long on 11/27/23.
//

import SwiftUI

/// Adds an onAppear modifier that's executed one time only.
/// ```
///    var body: some View {
///        Text("Hello")
///            .onAppearOnce {
///                // do something one time only
///            }
///    }
/// ```
extension View {
    public func onAppearOnce(perform action: @Sendable @escaping () -> Void) -> some View {
        modifier(OnAppearOnce(action: action))
    }
}

private struct OnAppearOnce: ViewModifier {
    let action: @Sendable () -> Void
    @State private var performAction = true
    func body(content: Content) -> some View {
        content.onAppear {
            if performAction {
                performAction = false
                action()
            }
        }
    }
}
