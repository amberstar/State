//
// State: Storable.swift
// Copyright © 2016 SIMPLETOUCH LLC. All rights reserved.
//

import Foundation
#if os(iOS)
    import UIKit
#endif

/*===----------------------------------------------------------------------===//
 * TODO: implement customDebugStringConvertible, Mirror?
 * TODO: add overloads with throws, for required props
 * TODO: add overloads with default values to Store
//===----------------------------------------------------------------------===*/

/// A type that can read and write it's properties to a Store.
public protocol Storable  {
    /// Stores the receiver to the given store.
    func store(to: inout Store)
    /// Restores a Storable from the given store.
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


