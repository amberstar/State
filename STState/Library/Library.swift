
public func +<T, V>(var lhs: [T: V], rhs: [T: V]) -> [T: V] {
    for (key, val) in rhs {
        lhs[key] = val
    }
    return lhs
}

public extension Dictionary {
    func map<A>(f: Value -> A) -> [Key: A] {
        return self.reduce([:]) { $0 + [$1.0: f($1.1)] }
    }
}

public func sequence<T>(xs: [T?]) -> [T]? {
    return xs.reduce([T]()) { accum, elem in
        return curry(+) <^> accum <*> (pure <^> elem)
    }
}

public func sequence<T>(xs: [String: T?]) -> [String: T]? {
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

infix operator >>> { associativity left precedence 150 }
public func >>><T,U>(a: T, f: T -> U? ) -> U? {
    return f(a)
}

public func curry<A, B, C>(f: (A, B) -> C) -> A -> B -> C {
    return { a in { b in f(a, b) }}
}


public protocol Semigroup {
    /// An associative binary operator.
    func op(other : Self) -> Self
}

extension Array : Semigroup {
    public func op(other : [Element]) -> [Element] {
        return self + other
    }
}

extension Dictionary : Semigroup {
    public func op(other: [Key : Value]) -> [Key : Value] {
        var source = self
        for (k, v) in other {
            source.updateValue(v, forKey: k)
        }
        return source
    }
}

public protocol Monoid : Semigroup {
    static var mempty : Self { get }
}

extension Array : Monoid {
    public static var mempty : [Element] { return [] }
}

extension Dictionary : Monoid {
    
    public static var mempty : [Key : Value] { return [:]
    }
}