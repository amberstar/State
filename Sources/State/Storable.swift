
//
// Storable.swift
// Copyright © 2016 Amber Star. All rights reserved.
//

import Foundation

/// Storables:
/// types that can be read and written to stores
///
/// Storables gain all the serialization, and
/// format conversion out of the box from PropertyListConvertible
///

/// A type that can read and write it's properties to a Store.
public protocol Storable : PropertyListConvertible {
    
    /// Create an instance from a property.
    init?(with: Store)
    /// Writes to the receiver to the given store.
    func write(to: inout Store)
}

public extension Storable {
    var propertyList : PropertyList {
        var s = Store()
        self.write(to: &s)
        return s.propertyList
    }
    
    init?(propertyList: PropertyList) {
        let s = Store(propertyList: propertyList)
        self.init(with: s)
    }
}

public extension Store {
    
    /// Return a value at key or nil if not found.
    func value<Value: Storable>(forKey key: String) -> Value? {
        guard let p = propertyList[key] as? [String: AnyObject] else { return nil }
        return Value(with: Store(propertyList: p))
    }
    
    /// Return a value at key or nil if not found.
    func value<Value: Storable>(forKey key: String) -> [Value]? {
        guard let p = propertyList[key] as? [[String: AnyObject]] else { return nil }
        return sequence(p.map { Value(with: Store(propertyList: $0)) })
    }
    
    /// Return a value at key or nil if not found.
    func value<Value: Storable>(forKey key: String) -> [String: Value]? {
        guard let data = propertyList[key] as? [String: [String: AnyObject]] else { return nil }
        return sequence(data.map { Value(with: Store(propertyList: $0)) })
    }
    
    /// Add or update the value at key.
    mutating func set<Value: Storable>(_ value: Value?, forKey key: String) {
        guard let value = value else { return }
        propertyList[key] = value.propertyList
    }
    
    /// Add or update the value at key.
    mutating func set<Value: Storable>(_ value: [Value]?, forKey key: String) {
        guard let value = value else { return }
        let data = value.reduce([PropertyList](), { (data, value) -> [PropertyList] in
            var vdata = data
            vdata.append(value.propertyList)
            return vdata
        })
        propertyList[key] = data
    }
    
    /// Add or update the value at key.
    mutating func set<Value: Storable>(_ value: [String: Value]?, forKey key: String) {
        guard let value = value
            else { return }
        let data = value.reduce([String: [String: Any]](), { (data, element) -> [String: PropertyList] in
            var vdata = data
            vdata[element.key] = element.value.propertyList
            return vdata
        })
        propertyList[key] = data
    }
}


// MARK: - Utility

public func sequence<T>(_ array: [T?]) -> [T]? {
    return array.reduce(.some([])) { accum, elem in
        guard let accum = accum, let elem = elem
            else { return nil }
        return accum + [elem]
    }
}

public func sequence<T>(_ dictionary: [String: T?]) -> [String: T]? {
    return dictionary.reduce(.some([:])) { accum, elem in
        guard let accum = accum, let value = elem.1
            else { return nil }
        var result = accum
        result[elem.0] = value
        return result
    }
}

extension Dictionary {

    public func map<A>(_ transform: (Value) -> A) -> [Key: A] {
        return self.reduce([:]) { accum, elem in
            var result = accum
            result[elem.0] = transform(elem.1)
            return result
        }
    }
}
