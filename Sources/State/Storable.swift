//
// State: Storable.swift
// Copyright © 2016 Amber Star. All rights reserved.
//

import Foundation

#if os(iOS)
    import UIKit
#endif

/*===----------------------------------------------------------------------===//
 * TODO: customDebugStringConvertible, Mirror?
 * TODO: add overloads with throws, for required props
 * TODO: add overloads with default values
//===----------------------------------------------------------------------===*/

public typealias PropertyList = [String : Any]

//===----------------------------------------------------------------------===//
// MARK: - Storeable

/// A type that can read and write it's properties to a Store.
public protocol Storable  {
    /// Stores the receiver to the given store.
    func store(to: inout Store)
    /// Restores the receiver from the given store.
    static func restore(from: Store) -> Self?
}

public extension Storable {
    var properties : PropertyList {
        var s = Store()
        self.store(to: &s)
        return s.properties
    }
    
    init?(properties: PropertyList) {
        let s = Store(properties: properties)
        if let instance = Self.restore(from: s) {
            self = instance
        }
        else {
            return nil
        }
    }
    
    /// Create an instance from a plist file.
    init?(plistFile file: URL) {
        guard let p = Format.plist.read(file) as? PropertyList else { return nil }
        self.init(properties: p)
    }
    
    /// Create an instance from a json file.
    init?(jsonFile file: URL) {
        guard let p = Format.json.read(file) as? PropertyList else { return nil }
        self.init(properties: p)
    }
    
    /// Create an instance from a binary file.
    init?(binaryFile file: URL) {
        guard let p = Format.binary.read(file) as? PropertyList else { return nil }
        self.init(properties: p)
    }
    
    /// Create an instance from binary data.
    init?(data: Data) {
        guard let p = Format.binary.read(data) as? PropertyList else { return nil }
        self.init(properties: p)
    }
    
    /// Write the receiver to a file in the specified format.
    ///
    /// - Returns: `true` if succeeded otherwise `false`
    func write(to location: URL, format: Format = .plist) -> Bool {
        return format.write(properties, to: location)
    }
    
    /// Return the receiver formatted to a json string.
    func makeJson() -> String? {
        return Format.json.makeString(from: properties)
    }
    
    /// Return the receiver formatted to binary data.
    func makeData() -> Data? {
        return Format.binary.makeData(from: properties, prettyPrint: true)
    }
}

/*===----------------------------------------------------------------------===//
 * MARK: - ARRAY SUPPORT
 *
 * TODO: Can this be on collection or sequence instead?
 *===----------------------------------------------------------------------===*/

public extension Array where Element: Storable {
    
    /// Create an array of elements from a property list.
    init?(properties: [PropertyList]) {
        guard let instance = sequence(properties.map { Element(properties:$0) })
            else { return nil }
        self = instance
    }
    
    /// Create an array of elements from a file in the specified format.
    private init?(file: URL, format: Format = Format.plist) {
        guard let d = format.read(file) as? [[String: AnyObject]]
            else { return nil }
        guard let instance = sequence(d.map { Element(properties: $0) })
            else { return nil }
        self = instance
    }
    
    /// Create an array of elements from a json file.
    init?(jsonFile file: URL) {
        self.init(file: file, format: .json)
    }
    
    /// Create an array of elements from a plist file.
    init?(plistFile file: URL) {
        self.init(file: file, format: .plist)
    }
    
    /// Create an array of elements from a binary file.
    init?(binaryFile file: URL) {
        self.init(file: file, format: .binary)
    }
    
    /// Create an array if elements from binary data.
    init?(data: Data) {
        guard let d = Format.binary.read(data) as? [[String: AnyObject]]
            else { return nil }
        guard let instance = sequence(d.map { Element(properties: $0) })
            else { return nil }
        self = instance
    }
    
    /// Writes the receiver to a file in the specified format.
    ///
    /// - Returns: `true` if succeeded otherwise `false`
    func write(to location: URL, format: Format = Format.plist) -> Bool {
        return format.write(makePropertyList() as AnyObject, to: location)
    }
    
    /// Returns the array of elements formatted to a json string.
    func makeJson() -> String? {
        return Format.json.makeString(from: makePropertyList())
    }
    
    /// Returns the array of elements formatted to binary data.
    func makeData() -> Data? {
        return Format.binary.makeData(from: makePropertyList() as AnyObject, prettyPrint: true)
    }
    
    /// Returns the array elements formatted to a property list.
    func makePropertyList() -> [PropertyList] {
        return self.reduce([PropertyList]()) { (accum, elem) -> [PropertyList] in
            var vaccum = accum
            vaccum.append(elem.properties)
            return vaccum
        }
    }
}

public extension Store {
    
    /// Return a value at key or nil if not found.
    func value<Value: Storable>(forKey key: String) -> Value? {
        guard let p = properties[key] as? [String: AnyObject] else { return nil }
        return Value.restore(from: Store(properties: p))
    }
    
    /// Return a value at key or nil if not found.
    func value<Value: Storable>(forKey key: String) -> [Value]? {
        guard let p = properties[key] as? [[String: AnyObject]] else { return nil }
        return sequence(p.map { Value.restore(from: Store(properties: $0))})
    }
    
    /// Return a value at key or nil if not found.
    func value<Value: Storable>(forKey key: String) -> [String: Value]? {
        guard let data = properties[key] as? [String: [String: AnyObject]] else { return nil }
        return sequence(data.map { Value.restore(from: Store(properties: $0))})
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
        let data = value.reduce([String: [String : Any]](),{ (data, element) -> [String: PropertyList] in
            var vdata = data
            vdata[element.key] = element.value.properties
            return vdata
        })
        properties[key] = data
    }
}

/*===----------------------------------------------------------------------===//
 * MARK: - STORE
 * Currently Store is a concrete implementation
 * because that is what meets the current needs.
 * It would be very easy to make it abstract.
 * For example UserDefaults could be a Store.
 *===----------------------------------------------------------------------===*/

/// A key-value container.
///
/// Used for coding storables similar to an NSCoder.
public struct Store: Storable {
    
    public static func restore(from store: Store) -> Store? {
        let i: Store = Store.init(properties: store.properties)
        return i
    }
    
    public var properties: PropertyList
    
    public init(with store: Store) {
        self.init(properties: store.properties)
    }
    
    /// Create an instance with initial data.
    public init(properties: PropertyList = [:]) {
        self.properties = properties
    }
    
    /// Writes the receiver to the given store.
    public func store(to target: inout Store) {
        for e in properties {
            target.set(e.value, forKey: e.key)
        }
    }
    
    /// Removes and returns the property at the specified key.
    /// or nil if not found.
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
            else { 
                return nil }
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
//===----------------------------------------------------------------------===//
// MARK: - Utility

/// Converts an array of optional values to an array of values.
///
/// - returns: a new array of values or nil if any values in the array are nil.
public func sequence<T>(_ array: [T?]) -> [T]? {
    return array.reduce(.some([])) { accum, elem in
        guard let accum = accum, let elem = elem
            else { return nil }
        return accum + [elem]
    }
}

/// Converts a dictionary of key, optional value pairs to key, value pairs.
///
/// - returns: a new dictionary of key, value pairs or nil if any values in the dictionary are nil.
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
   /// Maps a transform over values of a dictionary and returns a new dictionary.
    public func map<A>(_ transform: (Value) -> A) -> [Key: A] {
        return self.reduce([:]) { accum, elem in
            var result = accum
            result[elem.0] = transform(elem.1)
            return result
        }
    }
}

/*===----------------------------------------------------------------------===//
 * MARK: - FORMAT
 * Formatting - Support for conversion types
 *
 * Convert types to property lists. (key value data)
 * Converting to different formats. (binary, plist, json)
 * Basic read/write to files, strings, data
 *
 * TODO: make a protocol to support other types and uses
//===----------------------------------------------------------------------===*/

/// A Format can convert property lists to
/// some other form. Read and writes to files, strings, data. etc.
/// current support for JSON, Plists, and Binary.
public class Format {
    
    public static var binary: Format {
        return Format()
    }
    public static var json: Format {
        return JSONFormat()
    }
    public static var plist: Format {
        return PlistFormat()
    }
    
    /// Writes data to a file.
    /// - returns: true if succeeded, false if failed
    func write(_ object: Any, to url: URL) -> Bool {
        if let data = makeData(from: object, prettyPrint: true) {
            return ((try? data.write(to: url, options: [.atomic])) != nil)
        } else { return false }
    }
    
    /// Writes data to NSData.
    /// - returns: NSData or nil if failed
    func makeData(from object: Any,
                  prettyPrint: Bool) -> Data? {
        return NSKeyedArchiver.archivedData(withRootObject: object)
    }
    
    /// Writes data to String.
    /// - returns: a string or nil if failed
    func makeString(from object: Any) -> String? {
        if let data = makeData(from: object, prettyPrint: true) {
            return String(data: data, encoding: .utf8)
        } else {
            print("Could not make data")
            return nil
        }
    }
    
    /// Reads data and returns Data.
    /// - returns: a data object or nil
    func read(_ data: Data) -> Any? {
        return NSKeyedUnarchiver.unarchiveObject(with: data)
    }
    
    /// Reads file and create Data from a URL.
    /// - returns: a data object or nil
    func read(_ url: URL) -> Any? {
        if let data = try? Data(contentsOf: url) {
            return read(data)
        }
        return nil
    }
    
    /// Reads and creates Data from a string.
    /// - returns: a data object or nil
    func read(_ content: String) -> Any? {
        guard let data = makeData(from: content)
            else { return nil }
        return read(data)
    }
    /// Creates Data from a string.
    func makeData(from string: String) -> Data? {
        return string.data(using: .utf8, allowLossyConversion: true)
    }
}

final class JSONFormat: Format {
    
    override func read(_ data: Data) -> Any? {
        do {
            let o: Any = try JSONSerialization.jsonObject(
                with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            return o
        } catch let error as NSError {
            Swift.print(error)
            return nil
        }
    }
    
    override func makeData(from object: Any, prettyPrint: Bool) -> Data? {
        guard JSONSerialization.isValidJSONObject(object)
            else { return nil }
        let options: JSONSerialization.WritingOptions = prettyPrint ? .prettyPrinted : []
        let data: Data?
        
        do {
            data = try JSONSerialization.data(withJSONObject: object, options: options)
        }
        catch let error as NSError {
            Swift.print(error)
            data = nil
        }
        return data
    }
}

final class PlistFormat: Format {
    
    override func read(_ data: Data) -> Any? {
        do {
            let o: Any =
                try PropertyListSerialization.propertyList(from: data, options: [.mutableContainersAndLeaves], format: nil)
            return o
        } catch let error as NSError {
            Swift.print(error)
            return nil
        }
    }
    
    override func read(_ content: String) -> Any? {
        let s = content as NSString
        return s.propertyList()
    }
    
    override func makeData(from object: Any,
                           prettyPrint: Bool) -> Data? {
        guard PropertyListSerialization.propertyList(
            object, isValidFor: PropertyListSerialization.PropertyListFormat.xml)
            else {
                print("Object is invalid for property list serialization")
                return nil
        }
        do {
            let data: Data? = try PropertyListSerialization.data(
                fromPropertyList: object, format: PropertyListSerialization.PropertyListFormat.xml, options: .allZeros)
            return data
        } catch let error as NSError {
            Swift.print(error)
        }
        return nil
    }
}
