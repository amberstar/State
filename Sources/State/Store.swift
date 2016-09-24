
//
// Store.swift
// Copyright © 2016 Amber Star. All rights reserved.
//

import Foundation
#if os(iOS)
      import UIKit
#endif


///  Abstract key-value property storage for
///  reading a writing arbritrary values and models.
///
/// Stores are an intermediate in-memory container for
/// encoding and decoding, but they are also useful
/// for grouping together models, and values.
public protocol Store {
    // TODO: this should be a lazy collection
    var keys: [String] { get }
    subscript(key: String) -> Any { get set }
    /// Removes and returns the value at the specified key
    /// or .none if not found.
    mutating func remove(key: String) -> Any?
}


extension Store {
    /// Returns the value associated with the specified key.
    public func value<V>(forKey key: String) -> V? {
        guard let result = self[key] as? V else {
            return nil
        }
        return result
    }
    
    /// Returns the value associated with the specified key.
    public func value(forKey key: String) -> Int8? {
        guard let result = self[key] as? Int else {
            return nil
        }
        return Int8(result)
    }
    
    /// Returns the value associated with the specified key.
    public func value(forKey key: String) -> Int16? {
        guard let result = self[key] as? Int else {
            return nil
        }
        return Int16(result)
    }
    
    /// Returns the value associated with the specified key.
    public func value(forKey key: String) -> Int32? {
        guard let result = self[key] as? Int else {
            return nil
        }
        return Int32(result)
    }
    
    /// Returns the value associated with the specified key.
    public func value(forKey key: String) -> Int64? {
        guard let result = self[key] as? Int else {
            return nil
        }
        return Int64(result)
    }
    
    /// Returns the value associated with the specified key.
    public func value(forKey key: String) -> UInt? {
        guard let result = self[key] as? Int else {
            return nil
        }
        return UInt(result)
    }
    
    /// Returns the value associated with the specified key.
    public func value(forKey key: String) -> UInt8? {
        guard let result = self[key] as? Int else {
            return nil
        }
        return UInt8(result)
    }
    
    /// Returns the value associated with the specified key.
    public func value(forKey key: String) -> UInt16? {
        guard let result = self[key] as? Int else {
            return nil
        }
        return UInt16(result)
    }
    
    /// Returns the value associated with the specified key.
    public func value(forKey key: String) -> UInt32? {
        guard let result = self[key] as? Int else {
            return nil
        }
        return UInt32(result)
    }
    
    /// Returns the value associated with the specified key.
    public func value(forKey key: String) -> UInt64? {
        guard let result = self[key] as? Int else {
            return nil
        }
        return UInt64(result)
    }
    
    /// Returns the object associated with the specified key.
    public func object(forKey key: String) -> Any? {
        return self[key]
    }
    
    /// Returns the array associated with the specified key.
    public func array(forKey key: String) -> [Any]? {
        return self[key] as? [Any]
    }
    
    /// Returns the dictionary associated with the specified key.
    public func dictionary(forKey key: String) -> [String: Any]? {
        return self[key] as? [String: AnyObject]
    }
    
    /// Sets the value of the specified key to the specified value.
    public mutating func set<V>(_ value: V?, forKey key: String) {
        guard let value = value else { return }
        self[key] = value
    }
    
    /// Returns the url associated with the specified key.
    public func value(forKey key: String) -> URL? {
        guard let urlString: String = value(forKey: key)
            else { return nil }
        return URL(string: urlString)
    }
    
    /// Sets the value of the specified key to the specified url value.
    public mutating func set(_ value: URL?, forKey key: String) {
        guard let urlString: String = value?.absoluteString
            else { return }
        self[key] = urlString as NSString
    }
    
    #if os(iOS)
    
    /// Returns the color associated with the specified key.
    public func value(forKey key: String) -> UIColor? {
        
        guard
            let d = dictionary(forKey: key),
            let red: Float = d["red"] as? Float,
            let green: Float = d["green"] as? Float,
            let blue: Float = d["blue"] as? Float,
            let alpha: Float = d["alpha"] as? Float
            else { return nil }
        return UIColor(colorLiteralRed: red, green: green, blue: blue, alpha: alpha)
    }
    #endif
    
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
    #if os(iOS)
    /// Sets the value of the specified key to the specified color value.
    public mutating func set(_ value: UIColor?, forKey key: String) {
        guard let value = value
            else { return }
        var red, green, blue, alpha: CGFloat
        red = 0; green = 0; blue = 0; alpha = 0
        value.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        var cStore = DataStore()
        cStore.set(red, forKey: "red")
        cStore.set(green, forKey: "green")
        cStore.set(blue, forKey: "blue")
        cStore.set(alpha, forKey: "alpha")
        set(cStore, forKey: key)
    }
    #endif
    
    
    /// Create a store with file content in the specified format.
    public init?(file: URL, format: Format) {
        guard let data = format.read(file) as? [String: AnyObject]
            else { return nil }
        self.data = data
    }
    
    /// Writes the store content to a file in the specified format.
    ///
    /// - Returns: `true` if succeeded otherwise `false`
    public func write(to file: URL, format: Format) -> Bool {
        return format.write(data as AnyObject, to: file)
    }
    
    /// Returns the stores content as a string in the
    /// specified format.
    public func makeString(format: Format) -> String? {
        return format.makeString(from: data as AnyObject)
    }
    
    /// Create a store with a string in the specified format.
    public init?(content: String, format: Format) {
        guard let data = format.read(content) as? [String: AnyObject]
            else { return nil }
        self.data = data
    }
    
    /// Create a store with data in the specified format.
    public init?(content: Data, format: Format) {
        guard let data = format.read(content) as? [String: AnyObject]
            else { return nil }
        self.data = data
    }
    
    public func makeData(format: Format) -> Data? {
        return format.makeData(from: data as AnyObject, prettyPrint: true)
    }

}


/// A Dictionary backed Store 
public struct DataStore: Store, Storable {
    
    public var keys: [String] {
        return Array<String>(data.keys)
    }

    public subscript(key: String) -> Any {
        get {
            return data[key]
        }
        set {
            data[key] = newValue
        }
    }

    /// The contents of the store.
    public var data: [String: Any]

    /// Create an instance with initial data.
    public init(data: [String: Any] = [:]) {
        self.data = data
    }
    
    public mutating func remove(key: String) -> Any? {
        return data.removeValue(forKey: key)
    }
    public static func read(from source: Store) -> DataStore? {
        var s = DataStore()
        for key in source.keys {
            s[key] = source[key]
        }
        return s
    }
    
    public func write(to target: inout Store) {
        for e in data {
            target[e.key] = e.value
        }
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
