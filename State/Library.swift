infix operator <^> { associativity left }
infix operator <*> { associativity left }
infix operator >>- { associativity left precedence 150 }
infix operator -<< { associativity right precedence 150 }
infix operator >>> { associativity left precedence 150 }
infix operator <<< { associativity right precedence 150 }

/// Runes: https://github.com/thoughtbot/Runes


/// map a function over an array of values
/// This will return a new array resulting from the transformation function beind applied to each value in the array
/// - parameter f: A transformation function from type T to type U
/// - parameter a: A value of type [T]
/// - returns: A value of type [U]
public func <^><T, U>(f: T -> U, a: [T]) -> [U] {
    return a.map(f)
}


/// apply an array of functions to an array of values
/// This will return a new array resulting from the matrix of each function being applied to each value in the array
/// - parameter fs: An array of transformation functions from type T to type U
/// - parameter a: A value of type [T]
/// - returns: A value of type [U]
public func <*><T, U>(fs: [T -> U], a: [T]) -> [U] {
    return a.apply(fs)
}


/// Wrap a value in a minimal context of []
/// - parameter a: A value of type T
/// - returns: The provided value wrapped in an array
public func pure<T>(a: T) -> [T] {
    return [a]
}

extension Array {
    
    /// apply an array of functions to self
    /// This will return a new array resulting from the matrix of each function being applied to each value inside self
    /// - parameter fs: An array of transformation functions from type T to type U
    /// - returns: A value of type [U]
    func apply<U>(fs: [T -> U]) -> [U] {
        return fs.flatMap { self.map($0) }
    }
}


// pure merge for Dictionaries
func +<T, V>(var lhs: [T: V], rhs: [T: V]) -> [T: V] {
    for (key, val) in rhs {
        lhs[key] = val
    }
    return lhs
}

extension Dictionary {
    func map<A>(f: Value -> A) -> [Key: A] {
        return self.reduce([:]) { $0 + [$1.0: f($1.1)] }
    }
}


func curry<A, B, C>(f: (A, B) -> C) -> A -> B -> C {
    return { a in { b in f(a, b) }}
}

func sequence<T>(xs: [T?]) -> [T]? {
    return xs.reduce([T]()) { accum, elem in
        return curry(+) <^> accum <*> (pure <^> elem)
    }
}

func sequence<T>(xs: [String: T?]) -> [String: T]? {
    return xs.reduce(pure([:])) { accum, elem in
        return curry(+) <^> accum <*> ({ [elem.0: $0] } <^> elem.1)
    }
}

public func asOptional<T>(value: T?) -> Optional<Optional<T>> {
    if let v = value {
        return Optional.Some(v)
    } else {
        return Optional.Some(nil)
    }
}

public func >>><T,U>(a: T, f: T -> U? ) -> U? {
    return f(a)
}

/// Runes: https://github.com/thoughtbot/Runes


/// map a function over an optional value
/// * If the value is .None, the function will not be evaluated and this will return .None
/// * If the value is .Some, the function will be applied to the unwrapped value
///
/// - parameter f: A transformation function from type T to type U
/// - parameter a: A value of type Optional<T>
/// - returns: A value of type Optional<U>
public func <^><T, U>(f: T -> U, a: T?) -> U? {
    return a.map(f)
}


/// apply an optional function to an optional value
///
/// * If either the value or the function are .None, the function will not be evaluated and this will return .None
/// * If both the value and the function are .Some, the function will be applied to the unwrapped value
///
/// - parameter f: An optional transformation function from type T to type U
/// - parameter a: A value of type Optional<T>
///
/// - returns: A value of type Optional<U>
public func <*><T, U>(f: (T -> U)?, a: T?) -> U? {
    return a.apply(f)
}


/// flatMap a function over an optional value (left associative)
///
/// * If the value is .None, the function will not be evaluated and this will return .None
/// * If the value is .Some, the function will be applied to the unwrapped value
///
/// - parameter f: A transformation function from type T to type Optional<U>
/// - parameter a: A value of type Optional<T>
///
/// - returns: A value of type Optional<U>
public func >>-<T, U>(a: T?, f: T -> U?) -> U? {
    return a.flatMap(f)
}


/// flatMap a function over an optional value (right associative)
///
/// * If the value is .None, the function will not be evaluated and this will return .None
/// * If the value is .Some, the function will be applied to the unwrapped value
///
/// - parameter a: A value of type Optional<T>
/// - parameter f: A transformation function from type T to type Optional<U>
///
/// - returns: A value of type Optional<U>
public func -<<<T, U>(f: T -> U?, a: T?) -> U? {
    return a.flatMap(f)
}


/// Wrap a value in a minimal context of .Some
///
/// - parameter a: A value of type T
///
/// - returns: The provided value wrapped in .Some
public func pure<T>(a: T) -> T? {
    return .Some(a)
}

extension Optional {
    
    /// apply an optional function to self
    ///
    /// * If either self or the function are .None, the function will not be evaluated and this will return .None
    /// * If both self and the function are .Some, the function will be applied to the unwrapped value
    ///
    /// * parameter f: An optional transformation function from type T to type U
    ///
    /// * returns: A value of type Optional<U>
    func apply<U>(f: (T -> U)?) -> U? {
        return f.flatMap { self.map($0) }
    }
}