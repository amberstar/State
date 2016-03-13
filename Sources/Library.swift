
public func +<T, V>(lhs: [T: V], rhs: [T: V]) -> [T: V] {
    var l = lhs

    for (key, val) in rhs {
        l[key] = val
    }
    return l
}

public extension Dictionary {
    func map<A>(f: Value -> A) -> [Key: A] {
        let result  = self.reduce([:]) { $0 + [$1.0: f($1.1)] }
        return result
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

extension Dictionary {
    /// Merges the dictionary with dictionaries passed. The latter dictionaries will override
    /// values of the keys that are already set
    ///
    /// :param dictionaries A comma seperated list of dictionaries
    mutating func merge<K, V>(dictionaries: Dictionary<K, V>...) {
        for dict in dictionaries {
            for (key, value) in dict {
                self.updateValue(value as! Value, forKey: key as! Key)
            }
        }
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