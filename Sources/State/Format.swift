//
// State: Format.swift
// Copyright © 2016 SIMPLETOUCH LLC. All rights reserved.
//

import Foundation

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

    /// Writes data to and returns a `Data` plist object.
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

    /// Reads and returns a new `Data` plist object.
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

    /// Creates `Data` plist object from a string.
    func read(_ content: String) -> Any? {
        guard let data = makeData(from: content)
                else { return nil }
        return read(data)
    }
    /// Creates `Data` from a string.
    func makeData(from string: String) -> Data? {
        return string.data(using: .utf8, allowLossyConversion: true)
    }
}

final class JSONFormat: Format {

    /// Reads and returns a new `Data` plist object.
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

    /// Writes data to and returns a `Data` JSON object.
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

    /// Reads and returns a new `Data` plist object.
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

    /// Creates `Data` plist object from a string.
    override func read(_ content: String) -> Any? {
        let s = content as NSString
        return s.propertyList()
    }

    /// Writes data to and returns a `Data` plist object.
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