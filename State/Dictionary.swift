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