
//
// Storable.swift
// Copyright © 2016 Amber Star. All rights reserved.
//

import Foundation

#if os(iOS)
    import UIKit
#endif


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
    var properties : PropertyList {
        var s = Store()
        self.write(to: &s)
        return s.properties
    }
    
    init?(properties: PropertyList) {
        let s = Store(properties: properties)
        self.init(with: s)
    }
}

public extension Store {
    
    /// Return a value at key or nil if not found.
    func value<Value: Storable>(forKey key: String) -> Value? {
        guard let p = properties[key] as? [String: AnyObject] else { return nil }
        return Value(with: Store(properties: p))
    }
    
    /// Return a value at key or nil if not found.
    func value<Value: Storable>(forKey key: String) -> [Value]? {
        guard let p = properties[key] as? [[String: AnyObject]] else { return nil }
        return sequence(p.map { Value(with: Store(properties: $0)) })
    }
    
    /// Return a value at key or nil if not found.
    func value<Value: Storable>(forKey key: String) -> [String: Value]? {
        guard let data = properties[key] as? [String: [String: AnyObject]] else { return nil }
        return sequence(data.map { Value(with: Store(properties: $0)) })
    }
    
    /// Add or update the value at key.
    mutating func set<Value: Storable>(_ value: Value?, forKey key: String) {
        guard let value = value else { return }
        properties[key] = value.properties
    }
    
    /// Add or update the value at key.
    mutating func set<Value: Storable>(_ value: [Value]?, forKey key: String) {
        guard let value = value else { return }
        let data = value.reduce([PropertyList](), { (data, value) -> [PropertyList] in
            var vdata = data
            vdata.append(value.properties)
            return vdata
        })
        properties[key] = data
    }
    
    /// Add or update the value at key.
    mutating func set<Value: Storable>(_ value: [String: Value]?, forKey key: String) {
        guard let value = value
            else { return }
        let data = value.reduce([String: [String: Any]](), { (data, element) -> [String: PropertyList] in
            var vdata = data
            vdata[element.key] = element.value.properties
            return vdata
        })
        properties[key] = data
    }
}


/// A key-value container.
///
/// It is the target and source for
/// coding storables simillar to an NSCoder.
/// Storables write their properites to a store
///
/// A Store can be thought of as general plist,
/// that is also used as a coder like NSCoder.
/// It's an in memory container, that can later
/// be saved to a file or even stored to another store.
///
/// Currently Store is a concrete implementation
/// because that is what meets the current needs.
/// It would be very easy to make it abstract.
/// For example UserDefaults could be a Store.
public struct Store: Storable {
    
    public var properties: PropertyList
    
    public init(with store: Store) {
        self.init(properties: store.properties)
    }
    
    /// Create an instance with initial data.
    public init(properties: PropertyList = [:]) {
        self.properties = properties
    }
    
    /// Writes to the receiver to the given store.
    public func write(to target: inout Store) {
        for e in properties {
            target.set(e.value, forKey: e.key)
        }
    }
    
    public mutating func remove(key: String) -> Any? {
        return properties.removeValue(forKey: key)
    }
    
    /// Returns the value associated with the specified key.
    public func value<V>(forKey key: String) -> V? {
        guard let result = properties[key] as? V else {
            return nil
        }
        return result
    }
    
    /// Returns the value associated with the specified key.
    public func value(forKey key: String) -> Int8? {
        guard let result = properties[key] as? Int else {
            return nil
        }
        return Int8(result)
    }
    
    /// Returns the value associated with the specified key.
    public func value(forKey key: String) -> Int16? {
        guard let result = properties[key] as? Int else {
            return nil
        }
        return Int16(result)
    }
    
    /// Returns the value associated with the specified key.
    public func value(forKey key: String) -> Int32? {
        guard let result = properties[key] as? Int else {
            return nil
        }
        return Int32(result)
    }
    
    /// Returns the value associated with the specified key.
    public func value(forKey key: String) -> Int64? {
        guard let result = properties[key] as? Int else {
            return nil
        }
        return Int64(result)
    }
    
    /// Returns the value associated with the specified key.
    public func value(forKey key: String) -> UInt? {
        guard let result = properties[key] as? Int else {
            return nil
        }
        return UInt(result)
    }
    
    /// Returns the value associated with the specified key.
    public func value(forKey key: String) -> UInt8? {
        guard let result = properties[key] as? Int else {
            return nil
        }
        return UInt8(result)
    }
    
    /// Returns the value associated with the specified key.
    public func value(forKey key: String) -> UInt16? {
        guard let result = properties[key] as? Int else {
            return nil
        }
        return UInt16(result)
    }
    
    /// Returns the value associated with the specified key.
    public func value(forKey key: String) -> UInt32? {
        guard let result = properties[key] as? Int else {
            return nil
        }
        return UInt32(result)
    }
    
    /// Returns the value associated with the specified key.
    public func value(forKey key: String) -> UInt64? {
        guard let result = properties[key] as? Int else {
            return nil
        }
        return UInt64(result)
    }
    
    /// Returns the url associated with the specified key.
    public func value(forKey key: String) -> URL? {
        guard let urlString: String = value(forKey: key)
            else { return nil }
        return URL(string: urlString)
    }
    
    #if os(iOS)
    /// Returns the color associated with the specified key.
    public func value(forKey key: String) -> UIColor? {
        
        guard
            let d = properties(forKey: key),
            let red: Float = d["red"] as? Float,
            let green: Float = d["green"] as? Float,
            let blue: Float = d["blue"] as? Float,
            let alpha: Float = d["alpha"] as? Float
            else { return nil }
        return UIColor(colorLiteralRed: red, green: green, blue: blue, alpha: alpha)
    }
    #endif
    
    /// Returns the object associated with the specified key.
    public func anyValue(forKey key: String) -> Any? {
        return properties[key]
    }
    
    /// Returns the array associated with the specified key.
    public func array(forKey key: String) -> [Any]? {
        return properties[key] as? [Any]
    }
    
    /// Returns the dictionary associated with the specified key.
    public func properties(forKey key: String) -> PropertyList? {
        return properties[key] as? [String: AnyObject]
    }
    
    /// Returns a new store from the properties at the specified key.
    public func store(forKey key: String) -> Store? {
        guard let p = properties(forKey: key) else { return nil }
        return Store(properties: p)
    }
    
    
    /// Sets the value of the specified key to the specified value.
    public mutating func set<V>(_ value: V?, forKey key: String) {
        guard let value = value else { return }
        properties[key] = value
    }
    
    /// Sets the value of the specified key to the specified Int8 value.
    public mutating func set(_ value: Int8, forKey key: String) {
        set(Int(value), forKey: key)
    }
    
    /// Sets the value of the specified key to the specified Int16 value.
    public mutating func set(_ value: Int16, forKey key: String) {
        set(Int(value), forKey: key)
    }
    
    /// Sets the value of the specified key to the specified Int32 value.
    public mutating func set(_ value: Int32, forKey key: String) {
        set(Int(value), forKey: key)
    }
    
    /// Sets the value of the specified key to the specified Int64 value.
    public mutating func set(_ value: Int64, forKey key: String) {
        set(Int(value), forKey: key)
    }
    
    /// Sets the value of the specified key to the specified UInt value.
    public mutating func set(_ value: UInt, forKey key: String) {
        set(Int(value), forKey: key)
    }
    
    /// Sets the value of the specified key to the specified UInt8 value.
    public mutating func set(_ value: UInt8, forKey key: String) {
        set(Int(value), forKey: key)
    }
    
    /// Sets the value of the specified key to the specified UInt16 value.
    public mutating func set(_ value: UInt16, forKey key: String) {
        set(Int(value), forKey: key)
    }
    
    /// Sets the value of the specified key to the specified UInt32 value.
    public mutating func set(_ value: UInt32, forKey key: String) {
        set(Int(value), forKey: key)
    }
    
    /// Sets the value of the specified key to the specified UInt64 value.
    public mutating func set(_ value: UInt64, forKey key: String) {
        set(Int(value), forKey: key)
    }
    
    /// Sets the value of the specified key to the specified url value.
    public mutating func set(_ value: URL?, forKey key: String) {
        guard let urlString: String = value?.absoluteString
            else { return }
        properties[key] = urlString as NSString
    }
    
    #if os(iOS)
    /// Sets the value of the specified key to the specified color value.
    public mutating func set(_ value: UIColor?, forKey key: String) {
        guard let value = value
            else { return }
        var red, green, blue, alpha: CGFloat
        red = 0; green = 0; blue = 0; alpha = 0
        value.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        var cStore = Store()
        cStore.set(red, forKey: "red")
        cStore.set(green, forKey: "green")
        cStore.set(blue, forKey: "blue")
        cStore.set(alpha, forKey: "alpha")
        set(cStore, forKey: key)
    }
    #endif
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
