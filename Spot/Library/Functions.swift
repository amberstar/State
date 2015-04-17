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