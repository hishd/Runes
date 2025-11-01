//
//  BindableEnvironment.swift
//  Runes
//
//  Created by Michael Long on 12/4/24.
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@propertyWrapper
public struct BindableEnvironment<T: Observable & AnyObject>: DynamicProperty {
    @Environment(T.self) private var object: T

    public var wrappedValue: T {
        _object.wrappedValue
    }

    public var projectedValue: Bindable<T> {
        @Bindable var wrappedValue = wrappedValue
        return $wrappedValue
    }
    
    public init() {}
}
