//
//  SharedAsyncStream+Observers.swift
//  Runes
//
//  Created by Michael Long on 12/29/25.
//

extension SharedAsyncStream {
    ///  Registers a change observer to observe async events. This can be used as an alternative to for/await streams.
    ///  ```swift
    ///  service.addObserver(self) { element in
    ///     print("Observed \(element)")
    /// }
    /// ```
    /// The observer must be a reference type, as that's used to automatically remove the observer when the observing object goes out of scope.
    public func addObserver<O: AnyObject>(_ observer: O, onNext: @escaping @Sendable (Element) -> Void) {
        let key = "\(ObjectIdentifier(observer))"
        addAsyncObserver(observer, yield: onNext) { [weak self] in
            self?.removeAsyncObserver(key)
        }
    }

    /// Removes an observer from the list. Manual removal isn't normally needed since observers are automatically removed when the observing
    /// object goes out of scope. (As long as the closure doesn't contain a strong reference to self.)
    ///  ```swift
    ///  service.removeObserver(self)
    /// ```
    public func removeObserver<O: AnyObject>(_ observer: O) {
        let key = "\(ObjectIdentifier(observer))"
        removeAsyncObserver(key)
    }
}
