import Foundation

public extension Optional where Wrapped == String {
    public var isNullOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}


public extension Optional where Wrapped: Collection {
    public var isNullOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}

// Emptiness
public extension Optional {
    /// Returns true if the optional is empty
    var isNone: Bool {
        return self == .none
    }
    
    /// Returns true if the optional is not empty
    var isSome: Bool {
        return self != .none
    }
}

// Or
public extension Optional {
    /// Return the value of the Optional or the `default` parameter
    /// - param: The value to return if the optional is empty
    func or(_ default: Wrapped) -> Wrapped {
        return self ?? `default`
    }
    
    /// Returns the unwrapped value of the optional *or*
    /// the result of an expression `else`
    /// I.e. optional.or(else: print("Arrr"))
    func or(else: @autoclosure () -> Wrapped) -> Wrapped {
        return self ?? `else`()
    }
    
    /// Returns the unwrapped value of the optional *or*
    /// the result of calling the closure `else`
    /// I.e. optional.or(else: {
    /// ... do a lot of stuff
    /// })
    func or(else: () -> Wrapped) -> Wrapped {
        return self ?? `else`()
    }
    
    /// Returns the unwrapped contents of the optional if it is not empty
    /// If it is empty, throws exception `throw`
    func or(throw exception: Error) throws -> Wrapped {
        guard let unwrapped = self else { throw exception }
        return unwrapped
    }
}

extension Optional where Wrapped == Error {
    /// Only perform `else` if the optional has a non-empty error value
    func or(_ else: (Error) -> Void) {
        guard let error = self else { return }
        `else`(error)
    }
}
// Filter and expect
extension Optional {
    /// Returns the unwrapped value of the optional only if
    /// - The optional has a value
    /// - The value satisfies the predicate `predicate`
    func filter(_ predicate: (Wrapped) -> Bool) -> Wrapped? {
        guard let unwrapped = self,
            predicate(unwrapped) else { return nil }
        return self
    }
    
    /// Returns the wrapped value or crashes with `fatalError(message)`
    func expect(_ message: String) -> Wrapped {
        guard let value = self else { fatalError(message) }
        return value
    }
}
