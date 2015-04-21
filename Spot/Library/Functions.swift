func curry<A, B, C>(f: (A, B) -> C) -> A -> B -> C {
  return { a in { b in f(a, b) }}
}

func sequence<T>(xs: [T?]) -> [T]? {
    return reduce(xs, [T]()) { accum, elem in
        return curry(+) <^> accum <*> (pure <^> elem)
    }
}

func sequence<T>(xs: [String: T?]) -> [String: T]? {
    return reduce(xs, pure([:])) { accum, elem in
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