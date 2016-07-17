//
// State: Sources/Storage.swift
// Copyright © 2016 SIMPLETOUCH LLC. All rights reserved.
//
// Licensed under The MIT License (MIT)
//

/*
1. A `Store` is a light weight wrapper around a `Dictionary` to make
   it convienient to encode and decode models, and save them to files.

2. A`Formatter` is used internally by a Store to read and write it's
   data to files, strings, data.
*/

import Foundation

public struct Store {
    
    public var data : [String : AnyObject]
    
    public init(data: [String : AnyObject] = [:]) {
        self.data = data
    }
    
    public init(data: AnyObject?) {
        self.data = data as? [String : AnyObject] ?? [:]
    }
    
//===----------------------------------------------------------------------===//
    
// MARK: - Decoding

//===----------------------------------------------------------------------===//
    
    public func value<V>(forKey key: String) -> V? {
        return data[key] as? V
    }
    
    /// Return a value at key or nil if not found.
    public func value<Value: Model>(forKey key: String) -> Value? {
        guard let data = data[key] as? [String : AnyObject] else { return nil }
        return Value.read(from: Store(data: data))
    }
    
    /// Return a value at key or nil if not found.
    public func value<Value: Model>(forKey key: String) -> [Value]? {
        guard let data = data[key] as? [[String : AnyObject]] else { return nil }
        return sequence(data.map { Value.read(from: Store(data: $0)) })
    }
    
    /// Return a value at key or nil if not found.
    public func value<Value: Model>(forKey key: String) -> [String : Value]? {
        guard let data = data[key] as?  [String : [String : AnyObject]] else { return nil }
        return sequence(data.map { Value.read(from: Store(data: $0))})
    }
    
    public func store(forKey key: String) -> Store? {
        guard let data = data[key] as? [String : AnyObject] else { return nil }
        return Store(data: data)
    }
    
//===----------------------------------------------------------------------===//
    
// MARK: - Encoding
    
//===----------------------------------------------------------------------===//
    
    public mutating func set<V>(_ value: V?, forKey key: String) {
        guard let value = value else { return }
        data[key] = value as? AnyObject
    }
    
    /// Add or update the value at key.
    public mutating func set<Value: Model>(_ value: Value?, forKey key: String ) {
        guard let value = value else  { return }
        var vstore = Store()
        value.write(to: &vstore)
        data[key] = vstore.data
    }
    
    /// Add or update the value at key.
    public mutating func set<Value: Model>(_ value: [Value]?, forKey key: String) {
        guard let value = value else { return }
        
        let data  = value.reduce([[String : AnyObject]](), combine: { (data, value) -> [[String: AnyObject]] in
            var vstore = Store()
            var vdata = data
            value.write(to: &vstore )
            vdata.append(vstore.data)
            return vdata
        })
        
        self.data[key] = data
    }
    
    /// Add or update the value at key.
    public mutating func set<Value: Model>(_ value: [String : Value]?, forKey key: String) {
        
        guard let value = value else { return }
        let data = value.reduce([String : [String : AnyObject]](), combine: { (data, element) -> [String : [String : AnyObject]] in
            var vstore = Store()
            var vdata = data
            element.value.write(to: &vstore)
            vdata[element.key] = vstore.data
            return vdata
        })
        
        self.data[key] =  data
    }
    
    public mutating func set(_ store: Store, forKey key: String) {
        data[key] = store.data
    }
}

//----------------------------------------------------------------------------//

// MARK: - Utility

//----------------------------------------------------------------------------//

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
