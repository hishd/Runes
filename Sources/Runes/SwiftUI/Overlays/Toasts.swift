//
//  Toasts.swift
//  Runes
//
//  Created by Michael Long on 11/30/25.
//

import SwiftUI

@available(macOS, unavailable)
public protocol ToastViews: Hashable, Equatable, View {}

@available(macOS, unavailable)
public protocol Toasts {
    @MainActor func toast(duration: TimeInterval, @ViewBuilder content: () -> some View)
    @MainActor func toast(duration: TimeInterval, _ view: some ToastViews)
    @MainActor func dismiss()
}

@available(macOS, unavailable)
extension Toasts {
    @MainActor public func toast(@ViewBuilder content: () -> some View) {
        toast(duration: 2.0, content: content)
    }
    @MainActor public func toast(_ view: some ToastViews) {
        toast(duration: 2.0, view)
    }
    @MainActor public func toast(_ message: String, icon: String? = nil, foreground: Color? = nil, background: Color? = nil) {
        toast { Toast(message, icon: icon, foreground: foreground, background: background) }
    }
    @MainActor public func toast(error: Error) {
        toast(duration: 3.0) { Toast(error: error, icon: "exclamationmark.triangle.fill", foreground: .white, background: .red) }
    }
    @MainActor public func toast(error: String) {
        toast(duration: 3.0) { Toast(error: error, icon: "exclamationmark.triangle.fill", foreground: .white, background: .red) }
    }
}

@available(macOS, unavailable)
extension EnvironmentValues {
    @Entry public var toasts: Toasts = Overlays.shared
}

@available(macOS, unavailable)
extension View {
    public func toast<V: ToastViews>(_ view: Binding<V?>, duration: TimeInterval = 2.0) -> some View {
        self.modifier(ShowToastBindingModifier(view: view, duration: duration))
    }
}

@available(macOS, unavailable)
private struct ShowToastBindingModifier<V: ToastViews>: ViewModifier {
    var view: Binding<V?>
    var duration: TimeInterval

    func body(content: Content) -> some View {
        content
            .onChange(of: view.wrappedValue) {
                if let view = view.wrappedValue {
                    let configuration: Overlays.Configuration = .init(id: UUID(), duration: duration, content: AnyView(view)) 
                    Overlays.shared.show(.toast(configuration))
                    self.view.wrappedValue = nil
                }
            }
    }
}
