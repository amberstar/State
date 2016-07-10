//
// State: Sources/Storage.swift
// Copyright © 2016 SIMPLETOUCH LLC. All rights reserved.
//
// Licensed under The MIT License (MIT)
//

/*

1. A Store is an abstract type that can be
   read or written to.

2. A`Formatter` is used internally by a Store to read and write it's
   data to files, strings, data.

*/

import Foundation

/// data formats for storage.
public enum Format {
    /// binary plist format
    case binary
    /// xml plist format
    case plist
    /// json format
    case json

    /// returns a formatter that can
    /// read and write to the current format.
    var formatter : Formatter {
        switch self {
        case .binary:
            return Formatter()
        case .plist:
            return PlistFormatter()
        case .json:
            return JSONFormatter()
        }
    }
}

/// A generalization for writing and reading keyed values.
public protocol Store {

    /// Return a value at key or nil if not found.
    func value<Value>(forKey: String) -> Value?
    
    /// Add or update the value at key.
    mutating func set<Value>(_ value: Value?, forKey: String)
}

extension Store {

    /// Return a value at key or nil if not found.
    public func value<Value: Model>(forKey key: String) -> Value? {
        guard let data : [String : AnyObject] = value(forKey: key) else { return nil }
        return Value.read(from: DataStore(data: data))
    }

    /// Return a value at key or nil if not found.
    public func value<Value: Model>(forKey key: String) -> [Value]? {
        guard let data : [[String : AnyObject]] = value(forKey: key) else { return nil }
        return sequence(data.map { Value.read(from: DataStore(data: $0)) })
    }

    /// Return a value at key or nil if not found.
    public func value<Value: Model>(forKey key: String) -> [String : Value]? {
        guard let data : [String : [String : AnyObject]] = value(forKey: key) else { return nil }
        return sequence(data.map { Value.read(from: DataStore(data: $0))})
    }

    /// Add or update the value at key.
    public mutating func set<Value: Model>(_ value: Value?, forKey key: String ) {
        guard let value = value else  { return }
        var vstore: Store = DataStore()
        value.write(to: &vstore)
        let vdata = (vstore as! DataStore).data
        set(vdata, forKey: key)
    }

    /// Add or update the value at key.
    public mutating func set<Value: Model>(_ value: [Value]?, forKey key: String) {
        guard let value = value else { return }

        let data  = value.reduce([[String : AnyObject]](), combine: { (data, value) -> [[String: AnyObject]] in
            var vstore: Store  = DataStore()
            var vdata = data
            value.write(to: &vstore )
            vdata.append((vstore as! DataStore).data)
            return vdata
        })

        set(data , forKey: key)
    }

    /// Add or update the value at key.
    public mutating func set<Value: Model>(_ value: [String : Value]?, forKey key: String) {

        guard let value = value else { return }
        let data = value.reduce([String : [String : AnyObject]](), combine: { (data, element) -> [String : [String : AnyObject]] in
            var vstore: Store = DataStore()
            var vdata = data
            element.value.write(to: &vstore)
            vdata[element.key] = (vstore as! DataStore).data
            return vdata
        })

        set(data, forKey: key)
    }

    /// Return a value at key or `defaultValue` if key is not found.
    public func value<Value>(forKey key: String, defaultValue: Value) -> Value {
        return value(forKey: key) ?? defaultValue
    }

    /// Return a value at key or `defaultValue` if key is not found.
    public func value<Value: Model>(forKey key: String, defaultValue: Value) -> Value {
        return value(forKey: key) ?? defaultValue
    }

    /// Return a value at key or `defaultValue` if key is not found.
    public func value<Value: Model>(forKey key: String, defaultValue: [Value]) -> [Value] {
        return value(forKey: key) ?? defaultValue
    }

    /// Return a value at key or `defaultValue` if key is not found.
    public func value<Value: Model>(forKey key: String, defaultValue: [String : Value]) -> [String : Value] {
        return value(forKey: key) ?? defaultValue
    }
}

/// A dictionary store used internally for
/// file storage
struct DataStore : Store {

    var data : [String : AnyObject]

    init(data: [String : AnyObject]) {
        self.data = data
    }
    
    init(data: AnyObject?) {
        if let data = data as? [String : AnyObject] {
            self.init(data: data)
        } else {
            self.init(data: [:])
        }
    }

    init() {
        self.data = [:]
    }

    func value<Value>(forKey key: String) -> Value? {
        return data[key] as? Value
    }

    mutating func set<Value>(_ value: Value?, forKey key: String) {
        guard let value = value else { return }
        data[key] = value as? AnyObject
    }
}

// MARK: - Utility

func sequence<T>(_ array: [T?]) -> [T]? {
    return  array.reduce(.some([])) { accum, elem in
        guard let accum = accum, elem = elem else { return nil }
        return accum + [elem]
    }
}

func sequence<T>(_ dictionary: [String: T?]) -> [String: T]? {
    return dictionary.reduce(.some([:])) { accum, elem in
        guard let accum = accum, value = elem.1 else { return nil }
        var result = accum
        result[elem.0] = value
        return result
    }
}

extension Dictionary {

    func map<A>(_ transform: (Value) -> A) -> [Key: A] {
        return self.reduce([:]) { accum, elem in
            var result = accum
            result[elem.0] = transform(elem.1)
            return result
        }
    }
}
