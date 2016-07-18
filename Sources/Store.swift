//
// State: Store.swift
// Copyright © 2016 SIMPLETOUCH LLC. All rights reserved.
//
// Licensed under The MIT License (MIT)
//

import Foundation

/*
1. A `Store` is an abstract key-value property store for
    reading a writing values. 
 
2. A`Formatter` is used internally by a Store to read and write it's
   data to files, strings, data.
*/

public struct Store {
    
    public var data : [String : AnyObject]
    
    public init(data: [String : AnyObject] = [:]) {
        self.data = data
    }
    
    public init(data: AnyObject?) {
        self.data = data as? [String : AnyObject] ?? [:]
    }
    
// MARK: - Generic Values
    
    public func value<V>(forKey key: String) -> V? {
        return data[key] as? V
    }
    
    public mutating func set<V>(_ value: V?, forKey key: String) {
        guard let value = value else { return }
        data[key] = value as? AnyObject
    }
    
// MARK: - Typed Values
    
    public func bool(forKey key: String) -> Bool? {
        return value(forKey: key)
    }
    
    public func bool(forKey key: String, defaultValue: Bool) -> Bool {
        return bool(forKey: key) ?? defaultValue
    }
    
    public func set(_ value: Bool, forKey key: String) {
        set(value, forKey: key)
    }
    
// MARK: - Keyed Stores
    
    public func store(forKey key: String) -> Store? {
        guard let data = data[key] as? [String : AnyObject] else { return nil }
        return Store(data: data)
    }
    
    public mutating func set(_ store: Store, forKey key: String) {
        data[key] = store.data
    }
    
// MARK: FILE
    
    /// Initialize a `Store` from a file
    public init?(file: URL, format: Format) {
        guard let data = format.formatter.read(file) as? [String : AnyObject] else { return nil }
        self.data = data
    }
    
    /// Writes a store to a file
    ///
    /// - Returns: `true` if succeeded otherwise `false`
    public func write(to file: URL, format: Format) -> Bool {
        return format.formatter.write(data, to: file)
    }
    
// MARK: STRING
    public func makeString(format: Format) -> String? {
        return format.formatter.makeString(from: data)
    }
    
    public init?(content: String, format: Format) {
        guard let data = format.formatter.read(content) as? [String : AnyObject] else { return nil }
        self.data = data
    }
    
// MARK: DATA
    
    public init?(content: Data, format: Format) {
        guard let data = format.formatter.read(content) as? [String : AnyObject] else { return nil }
        self.data = data
    }
    
    public func makeData(format: Format) -> Data? {
        return format.formatter.makeData(from: data, prettyPrint: true)
    }
}

// MARK: - Utility

public func sequence<T>(_ array: [T?]) -> [T]? {
    return  array.reduce(.some([])) { accum, elem in
        guard let accum = accum, elem = elem else { return nil }
        return accum + [elem]
    }
}

public func sequence<T>(_ dictionary: [String: T?]) -> [String: T]? {
    return dictionary.reduce(.some([:])) { accum, elem in
        guard let accum = accum, value = elem.1 else { return nil }
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

