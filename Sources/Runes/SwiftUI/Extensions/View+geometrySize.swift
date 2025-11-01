//
//  View+geometrySize.swift
//  Runes
//
//  Created by Michael Long on 7/29/24.
//

import SwiftUI

extension View {
    public func geometry(size: Binding<CGSize>) -> some View {
        self.modifier(ContentSizePreferenceModifier(size: size))
    }
}

struct ContentSizePreferenceModifier: ViewModifier {
    @Binding var size: CGSize
    func body(content: Content) -> some View {
        content
            .background (
                GeometryReader { geometry in
                    Color.clear.preference(key: ContentSizePreferenceKey.self, value: geometry.size)
                }
            )
            .onPreferenceChange(ContentSizePreferenceKey.self) {
                size = $0
            }
    }
}

struct ContentSizePreferenceKey: PreferenceKey {
    static let defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
