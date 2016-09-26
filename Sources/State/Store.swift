//
// Store.swift
// Copyright © 2016 Amber Star. All rights reserved.
//
import Foundation
#if os(iOS)
    import UIKit
#endif

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
    
    public var propertyList: PropertyList
    
    public init(with store: Store) {
        self.init(propertyList: store.propertyList)
    }
    
    /// Create an instance with initial data.
    public init(propertyList: PropertyList = [:]) {
        self.propertyList = propertyList
    }
    
    /// Writes to the receiver to the given store.
    public func write(to target: inout Store) {
        for e in propertyList {
            target.set(e.value, forKey: e.key)
        }
    }
    
    public mutating func remove(key: String) -> Any? {
        return propertyList.removeValue(forKey: key)
    }
    
    /// Returns the value associated with the specified key.
    public func value<V>(forKey key: String) -> V? {
        guard let result = propertyList[key] as? V else {
            return nil
        }
        return result
    }
    
    /// Returns the value associated with the specified key.
    public func value(forKey key: String) -> Int8? {
        guard let result = propertyList[key] as? Int else {
            return nil
        }
        return Int8(result)
    }
    
    /// Returns the value associated with the specified key.
    public func value(forKey key: String) -> Int16? {
        guard let result = propertyList[key] as? Int else {
            return nil
        }
        return Int16(result)
    }
    
    /// Returns the value associated with the specified key.
    public func value(forKey key: String) -> Int32? {
        guard let result = propertyList[key] as? Int else {
            return nil
        }
        return Int32(result)
    }
    
    /// Returns the value associated with the specified key.
    public func value(forKey key: String) -> Int64? {
        guard let result = propertyList[key] as? Int else {
            return nil
        }
        return Int64(result)
    }
    
    /// Returns the value associated with the specified key.
    public func value(forKey key: String) -> UInt? {
        guard let result = propertyList[key] as? Int else {
            return nil
        }
        return UInt(result)
    }
    
    /// Returns the value associated with the specified key.
    public func value(forKey key: String) -> UInt8? {
        guard let result = propertyList[key] as? Int else {
            return nil
        }
        return UInt8(result)
    }
    
    /// Returns the value associated with the specified key.
    public func value(forKey key: String) -> UInt16? {
        guard let result = propertyList[key] as? Int else {
            return nil
        }
        return UInt16(result)
    }
    
    /// Returns the value associated with the specified key.
    public func value(forKey key: String) -> UInt32? {
        guard let result = propertyList[key] as? Int else {
            return nil
        }
        return UInt32(result)
    }
    
    /// Returns the value associated with the specified key.
    public func value(forKey key: String) -> UInt64? {
        guard let result = propertyList[key] as? Int else {
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
            let d = propertyList(forKey: key),
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
        return propertyList[key]
    }
    
    /// Returns the array associated with the specified key.
    public func array(forKey key: String) -> [Any]? {
        return propertyList[key] as? [Any]
    }
    
    /// Returns the dictionary associated with the specified key.
    public func propertyList(forKey key: String) -> PropertyList? {
        return propertyList[key] as? [String: AnyObject]
    }
    
    /// Returns a new store from the propertyList as the specified key.
    public func store(forKey key: String) -> Store? {
        guard let p = propertyList(forKey: key) else { return nil }
        return Store(propertyList: p)
    }
    
    
    /// Sets the value of the specified key to the specified value.
    public mutating func set<V>(_ value: V?, forKey key: String) {
        guard let value = value else { return }
        propertyList[key] = value
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
        propertyList[key] = urlString as NSString
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
