
//
// State: Model.swift
// Copyright © 2016 SIMPLETOUCH LLC. All rights reserved.
//
// Licensed under The MIT License (MIT)
//

import Foundation
import UIKit

/*
 
 `Models`, and collections of them can be
  written and read to json and plist files, `Store`s, `UserDefaults`,
  `Strings`, or `Data`. They have methods
  to support migration and versioning.
 
  Migration is opt-in. To support migration:

  * implement `static func writeVersion(with: Store)`

     this method should be called in the `write(to:)` method
     before writing to a store is finished to give the model an
     opertunity to write version information to the store.

  * implement `static func migrate(from: Store) -> Store`

     this function should be called in the `read(from:)` method
     before reading any values from the store to give the model 
     an opertunity to migrate the store. Here the model should:

    -  read the version information from the store
    -  compare the version information with the "current version"
    -  add, remove, and update keys, and values to the store 
    -  return the updated store.
    
   in the `read(from:)` method use the migrated store to read
   and instantiate the model instance.
*/

public protocol Model {
    
    /// creates a `Model` instance from
    /// a store.
    static func read(from: Store) -> Self?
    
    /// called after reading is finished
    /// to give a model an opertunity
    /// to prepare or to read extra values
    /// from the store before instantiation
    func finishReading(from: Store)
    
    /// Writes the`Model` to a `Store`
    func write(to: inout Store)
    
    /// called before writing is finished
    /// to give the model an opertunity
    /// to write extra values to the store
    func finishWriting(to: inout Store)
    
    /// writes the model version to the store.
    ///
    /// This is called before writing a model to 
    /// a store is complete to give the model
    /// an opertunity to write version information
    /// to the store for migration purporses.
    static func writeVersion(to: Store)
    
    /// migrates a store to the current version if needed.
    ///
    /// the default implementation returns the origional store
    /// models can update the store to the current version
    /// by adding, removing, and changing keys ans values in the
    /// store, and return the updated store.
    static func migrate(from: Store) -> Store
}

extension Model {
  
    /// Initialize a `Model` from a file
    public init?(file: URL, format: Format) {
        guard let data = format.formatter.read(file) else { return nil }
        guard let instance = Self.read(from: Store(data: data)) else { return nil }
        self = instance
    }
    
    public init?(content: String, format: Format) {
        guard let data = format.formatter.read(content) else { return nil }
        guard let instance = Self.read(from: Store(data: data)) else { return nil }
        self = instance
    }
    
    public init?(content: Data, format: Format) {
        guard let data = format.formatter.read(content) else { return nil }
        guard let instance = Self.read(from: Store(data: data)) else { return nil }
        self = instance
    }
    
    /// Writes a model to a file
    ///
    /// - Returns: `true` if succeeded otherwise `false`
    public func write(to file: URL, format: Format) -> Bool {
        var vstore = Store()
        self.write(to: &vstore)
        return format.formatter.write(vstore.data, to: file)
    }
    
    public func makeString(format: Format) -> String? {
        var vstore = Store()
        self.write(to: &vstore)
        return format.formatter.makeString(from: vstore.data)
    }
    
    public func makeData(format: Format) -> Data? {
        var vstore = Store()
        self.write(to: &vstore)
        return format.formatter.makeData(from: vstore.data, prettyPrint: true)
    }
    
    // The following default implementations do nothing to provide them as optional.
    
    public static func migrate(from source: Store) -> Store {  return source }
    public static func writeVersion(to: Store) { } // default implementation does nothing
    public func finishReading(from: Store)  { } // default implementation does nothing
    public func finishWriting(to: inout Store) { } // default implementation does nothing
}


// TODO: Refactor these collections to reduce repeating

extension Array where Element: Model {
    
    public init?(file: URL, format: Format) {
        guard let data = format.formatter.read(file) as? [[String : AnyObject]] else { return nil }
        guard let instance =  sequence(data.map { Element.read(from: Store(data: $0)) }) else  { return nil }
        self = instance
    }
    
    /// Writes a model to a file
    ///
    /// - Returns: `true` if succeeded otherwise `false`
    public func write(to file: URL, format: Format) -> Bool {
        return format.formatter.write(encodeToData(), to: file)
    }
    
    // make string
    public func makeString(format: Format) -> String? {
        return format.formatter.makeString(from: encodeToData())
    }
    
    // make data
    public func makeData(format: Format) -> Data? {
        return format.formatter.makeData(from: encodeToData(), prettyPrint: true)
    }
    
    func encodeToData() -> AnyObject {
    
       return self.reduce([[String :  AnyObject]]()) { (accum, elem) -> [[String : AnyObject]] in
            var vaccum = accum
            var vstore = Store()
            elem.write(to: &vstore)
            vaccum.append(vstore.data)
            return vaccum
        }
    }
}

extension Dictionary where Key: AnyObject, Value: Model {
    
    public init?(file: URL, format: Format) {
        guard let fileData = format.formatter.read(file) as? [Key : [String : AnyObject]] else { return nil }
        let data : [Key : Value?] = fileData.map { Value.read(from: Store(data: $0)) }
        
        guard let instance : [Key : Value] = data.reduce(.some([:]), combine: { accum, elem in
            guard let accum = accum, value = elem.1 else { return nil }
            var result = accum
            result[elem.0] = value
            return result
            })
            else { return nil }

       self = instance
    }
    
    public func write(to file: URL, format: Format) -> Bool  {
        return format.formatter.write(encodeToData(), to: file)
    }
    
    public func makeString(format: Format) -> String? {
        return format.formatter.makeString(from: encodeToData())
    }
    
    public func makeData(format: Format) -> Data? {
        return format.formatter.makeData(from: encodeToData(), prettyPrint: true)
    }
    
    func encodeToData() -> AnyObject {
        return self.reduce( [Key : [String : AnyObject]]()) { (accum, elem) -> [Key : [String : AnyObject]] in
            var vaccum = accum
            var vstore = Store()
            elem.value.write(to: &vstore)
            vaccum[elem.key] = vstore.data
            return vaccum
        }
    }
}

extension Set where Element: Model {
    
    public init?(file: URL, format: Format) {
        guard let data = format.formatter.read(file) as? [[String : AnyObject]] else { return nil }
        guard let instance =  sequence(data.map { Element.read(from: Store(data: $0)) }) else  { return nil }
        self = Set(instance)
    }

    /// Writes a model to a file
    ///
    /// - Returns: `true` if succeeded otherwise `false`
    public func write(to file: URL, format: Format) -> Bool {
        return format.formatter.write(encodeToData(), to: file)
    }
    
    // make string
    public func makeString(format: Format) -> String? {
        return format.formatter.makeString(from: encodeToData())
    }
    
    // make data
    public func makeData(format: Format) -> Data? {
        return format.formatter.makeData(from: encodeToData(), prettyPrint: true)
    }
    
    func encodeToData() -> AnyObject {
        
        return self.reduce([[String :  AnyObject]]()) { (accum, elem) -> [[String : AnyObject]] in
            var vaccum = accum
            var vstore = Store()
            elem.write(to: &vstore)
            vaccum.append(vstore.data)
            return vaccum
        }
    }
}

extension UIColor : Model {
    
    public static func read(from store: Store) -> Self? {
    
        if let
            red: CGFloat  = store.value(forKey: "red"),
            green: CGFloat = store.value(forKey: "green"),
            blue:  CGFloat  = store.value(forKey: "blue"),
            alpha: CGFloat = store.value(forKey: "alpha") {
            
            return self.init(red: red, green: green, blue: blue, alpha: alpha)
        }
        else {
            return nil
        }
    }
    
    public func write(to store: inout Store) {
        var red, green, blue, alpha  : CGFloat
        red = 0; green = 0; blue = 0; alpha = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        store.set(red, forKey: "red")
        store.set(green, forKey: "green")
        store.set(blue, forKey: "blue")
        store.set(alpha, forKey: "alpha")
    }
}

extension Store {
    
    /// Return a value at key or nil if not found.
    public func value<Value: Model>(forKey key: String) -> Value? {
        guard let data = data[key] as? [String : AnyObject] else { return nil }
        return Value.read(from: Store(data: data))
    }
    
    /// Return a value at key or default value if not found.
    public func value<Value: Model>(forKey key: String, defaultValue: Value) -> Value {
        return value(forKey: key) ?? defaultValue
    }
    
    /// Return a value at key or nil if not found.
    public func value<Value: Model>(forKey key: String) -> [Value]? {
        guard let data = data[key] as? [[String : AnyObject]] else { return nil }
        return sequence(data.map { Value.read(from: Store(data: $0)) })
    }
    
    public func value<Value: Model>(forKey key: String, defaultValue: [Value]) -> [Value] {
        return value(forKey: key) ?? defaultValue
    }
    
    /// Return a value at key or nil if not found.
    public func value<Value: Model>(forKey key: String) -> [String : Value]? {
        guard let data = data[key] as?  [String : [String : AnyObject]] else { return nil }
        return sequence(data.map { Value.read(from: Store(data: $0))})
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
}
