//
//  BlockingSpinnerModifier.swift
//  Runes
//
//  Created by Michael Long on 10/20/25.
//

import SwiftUI

public extension View {
    func onShowBlockingSpinner(_ show: Bool) -> some View {
        ZStack {
            self
            if show {
                Color.black
                    .ignoresSafeArea(edges: .all)
                    .opacity(0.5)
                ProgressView()
                    .scaleEffect(2.0)
                    .foregroundColor(.primary)
            }
        }
    }
}
