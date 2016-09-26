
//
// Formatting.swift
// Copyright © 2016 Amber Star. All rights reserved.
//

import Foundation

/// Formatting - Support for conversion types
///
/// Convert types to property lists. (key value data)
/// Convertion to different formats. (binary, plist, json)
/// Basic read/write to files, strings, data

// TODO: CustomDebugStringConvertible, Mirror?

public typealias PropertyList = [String : Any]

/// A type that can provide it's properties
/// as a key value property list.
public protocol PropertyListConvertible {
    var properties: PropertyList { get }
    init?(properties: PropertyList)
}

public extension PropertyListConvertible {
    
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
    
    /// Write the reciever to a file in the specified format.
    ///
    /// - Returns: `true` if succeeded otherwise `false`
    func write(to location: URL, format: Format = .plist) -> Bool {
        return format.write(properties, to: location)
    }
    
    /// Return the reciever formatted to a json string.
    func makeJson() -> String? {
        return Format.json.makeString(from: properties)
    }
    
    /// Return the reciever formatted to binary data.
    func makeData() -> Data? {
        return Format.binary.makeData(from: properties, prettyPrint: true)
    }
}

//===----------------------------------------------------------------------===//
// MARK: - ARRAY SUPPORT


// TODO: Can this be on collection or sequence instead?
public extension Array where Element: PropertyListConvertible {
    
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
    
    /// Writes the reciever to a file in the specified format.
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
    
    /// Returns the array elements formatted to a propert list.
    func makePropertyList() -> [PropertyList] {
        return self.reduce([PropertyList]()) { (accum, elem) -> [PropertyList] in
            var vaccum = accum
            vaccum.append(elem.properties)
            return vaccum
        }
    }
}

//===----------------------------------------------------------------------===//
// MARK: - FORMAT

// TODO: make a protocol to support other types and uses

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

    /// write data to a file
    /// - returns: true if succeeded, false if failed
    func write(_ object: Any, to url: URL) -> Bool {
        if let data = makeData(from: object, prettyPrint: true) {
            return ((try? data.write(to: url, options: [.atomic])) != nil)
        } else { return false }
    }

    /// write data to  NSData
    /// - returns: NSData or nil if failed
    func makeData(from object: Any,
        prettyPrint: Bool) -> Data? {
        return NSKeyedArchiver.archivedData(withRootObject: object)
    }

    /// write data to String
    /// - returns: a string or nil if failed
    func makeString(from object: Any) -> String? {
        if let data = makeData(from: object, prettyPrint: true) {
            return String(data: data, encoding: .utf8)
        } else {
            print("Could not make data")
            return nil
        }
    }

    /// Read data from NSData
    /// - returns: a data object or nil
    func read(_ data: Data) -> Any? {
        return NSKeyedUnarchiver.unarchiveObject(with: data)
    }

    /// Read file from a URL
    /// - returns: a data object or nil
    func read(_ url: URL) -> Any? {
        if let data = try? Data(contentsOf: url) {
            return read(data)
        }
        return nil
    }

    /// Read data from a string
    /// - returns: a data object or nil
    func read(_ content: String) -> Any? {
        guard let data = makeData(from: content)
            else { return nil }
        return read(data)
    }

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
