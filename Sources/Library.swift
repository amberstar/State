infix operator <^> { associativity left precedence 130 }
infix operator <*> { associativity left precedence 130 }
infix operator >>- { associativity left precedence 100 }
infix operator -<< { associativity right precedence 100 }

/**
 map a function over an optional value
 
 - If the value is .None, the function will not be evaluated and this will return .None
 - If the value is .Some, the function will be applied to the unwrapped value
 
 - parameter f: A transformation function from type T to type U
 - parameter a: A value of type Optional<T>
 
 - returns: A value of type Optional<U>
 */
public func <^><T, U>(@noescape f: T -> U, a: T?) -> U? {
   return a.map(f)
}


/**
 apply an optional function to an optional value
 
 - If either the value or the function are .None, the function will not be evaluated and this will return .None
 - If both the value and the function are .Some, the function will be applied to the unwrapped value
 
 - parameter f: An optional transformation function from type T to type U
 - parameter a: A value of type Optional<T>
 
 - returns: A value of type Optional<U>
 */
public func <*><T, U>(f: (T -> U)?, a: T?) -> U? {
   return a.apply(f)
}


/**
 flatMap a function over an optional value (left associative)
 
 - If the value is .None, the function will not be evaluated and this will return .None
 - If the value is .Some, the function will be applied to the unwrapped value
 
 - parameter f: A transformation function from type T to type Optional<U>
 - parameter a: A value of type Optional<T>
 
 - returns: A value of type Optional<U>
 */
public func >>-<T, U>(a: T?, @noescape f: T -> U?) -> U? {
   return a.flatMap(f)
}


public extension Optional {
   /**
    apply an optional function to self
    
    - If either self or the function are .None, the function will not be evaluated and this will return .None
    - If both self and the function are .Some, the function will be applied to the unwrapped value
    
    - parameter f: An optional transformation function from type T to type U
    
    - returns: A value of type Optional<U>
    */
   public func apply<U>(f: (Wrapped -> U)?) -> U? {
      return f.flatMap { self.map($0) }
   }
}

/**
 Wrap a value in a minimal context of []
 
 - parameter a: A value of type T
 
 - returns: The provided value wrapped in an array
 */
public func pure<T>(a: T) -> [T] {
   return [a]
}

/**
 Wrap a value in a minimal context of .Some
 
 - parameter a: A value of type T
 
 - returns: The provided value wrapped in .Some
 */
public func pure<T>(a: T) -> T? {
   return .Some(a)
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

public func curry<A, B, C>(f: (A, B) -> C) -> A -> B -> C {
    return { a in { b in f(a, b) }}
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
    
    public func map<A>(f: Value -> A) -> [Key: A] {
        let result  = self.reduce([:]) { $0 + [$1.0: f($1.1)] }
        return result
    }
}

public func +<T, V>(lhs: [T: V], rhs: [T: V]) -> [T: V] {
   var l = lhs
   
   for (key, val) in rhs {
      l[key] = val
   }
   return l
}