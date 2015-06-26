
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

infix operator >>> { associativity left precedence 150 }
public func >>><T,U>(a: T, f: T -> U? ) -> U? {
    return f(a)
}

func curry<A, B, C>(f: (A, B) -> C) -> A -> B -> C {
    return { a in { b in f(a, b) }}
}