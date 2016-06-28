
//
// State: Sources/Coding.swift
// Copyright © 2016 SIMPLETOUCH LLC. All rights reserved.
//
// Licensed under The MIT License (MIT)
//

///
/// Coding -  encoding and decoding
///


// TODO:  - Add support for error handeling
//        Currently decoding returns nil upon failure

import Foundation

public enum DecodingError : ErrorProtocol {
    case keyNotFound(String)
    
    public init(key: String) {
        self = .keyNotFound(errorMessage("Decoding Error, Key Not Found: \(key)"))
    }
}

func errorMessage(_ reason: String, function: String = #function ,file: String = #file, line: Int = #line) -> String {
    return "reason: \(reason) function: \(function) file: \((file as NSString).lastPathComponent) line: \(line)"
}

public enum Format {
    
    case binary
    case plist
    case json
    
    var formatter : Formatter {
        switch self {
        case .binary:
            return Formatter()
        case .plist:
            return PlistFormatter()
        case .json:
            return JSONFormatter()
        }
    }
}

public protocol Encodable {
    func encode(with encoder: Encoder)
    func finishEncoding(with encoder: Encoder)
}

extension Encodable {
    
    /// write data to a file
    /// - returns: true if succeeded, false if failed
    public func write(to file: URL, format: Format) -> Bool {
        return format.formatter.write(_encode(), to: file)
    }
    
    /// write data to  NSData
    /// - returns: NSData or nil if failed
    public func makeData(format: Format) -> Data? {
        return format.formatter.makeData(from: _encode(), prettyPrint: true)
    }
    
    /// write data to String
    /// - returns: a string or nil if failed
    public func makeString(format: Format) -> String? {
        return format.formatter.makeString(from: _encode())
    }
    
    public func finishEncoding(with encoder: Encoder) { }
    
    func _encode() -> [String : AnyObject] {
        let encoder = Encoder()
        self.encode(with: encoder)
        return encoder.data
    }
}

public protocol EncoderType : class {
    
    var data : [String : AnyObject] { get set }
}

extension EncoderType {
    
    public func encode<T: Encodable>(_ value: T?, _ key: String) {
        guard let value = value else { return }
        data[key] = value._encode()
    }
    
    public func encode<T: Encodable>(_ value: [T]?, _ key: String) {
        guard let value = value else { return }
        data[key] = value.map { $0._encode() }
    }
    
    public func encode<T: Encodable>(_ value: [String : T]?, _ key: String) {
        guard let value = value else { return }
        data[key] = value.map { $0._encode() }
    }
    
    public func encode<V>(_ value: V?, _ key: String) {
        guard let value = value else { return }
        self.data[key] = value as? AnyObject
    }
}

public final class Encoder : EncoderType {
    
    public var data = [String : AnyObject]()
}

// Mark - Decoding

public protocol Decodable {
    static func decode(with decoder: Decoder) -> Self?
    func finishDecoding(with decoder: Decoder)
}

extension Decodable {
    
    public init?(file: URL, format: Format) {
        guard let data = format.formatter.read(file) else { return nil}
        guard let instance = Self.decode(with: Decoder(data: data)) else { return nil }
        self = instance
    }
    
    public init?(_ content: String, format: Format) {
        precondition(format != .binary, "Invalid format, String content cannot be Binary")
        guard let data = format.formatter.read(content) else { return nil }
        guard let instance = Self.decode(with: Decoder(data: data)) else { return nil }
        self = instance
        
    }
    
    public func finishDecoding(with decoder: Decoder) { }
    
    public init?(data: Data, format: Format) {
        guard let data = format.formatter.read(data) else { return nil }
        guard let instance = Self.decode(with: Decoder(data: data)) else { return nil }
        self = instance
    }
}

public protocol DecoderType {
    
    var data :[String : AnyObject] { get set }
}

extension DecoderType {
    
    /// decode a decodable element
    /// - parameter key: a dictionary to use for decoding
    /// - returns: return element of type T or nil if decoding failed
    public func decode<T:Decodable>(_ key: String) -> T? {
        let d = data[key] as? [String : AnyObject]
        return d.flatMap(_decodeDecodable)
    }
    
    /// decode a decodable array of element T
    /// - parameter key: a dictionary to use for decoding
    /// - returns: return an optional array of T or nil
    /// if decoding failed
    public func decode<T:Decodable>(_ key: String) -> [T]? {
        let d = data[key] as? [[String : AnyObject]]
        return d.flatMap { sequence($0.map( _decodeDecodable)) }
    }
    
    /// decode a dictionary of string,decodable element T
    /// - parameter key: a dictionary to use for decoding
    /// - returns: return a dictionary of string, element T
    /// or nil if decoding failed
    public func decode<T: Decodable>(_ key: String) -> [String : T]? {
        let d = data[key] as? [String : [String : AnyObject]]
        return d.flatMap { sequence($0.map(_decodeDecodable)) }
    }
    
    /// decode a value element V
    /// - parameter key: a dictionary to use for decoding
    /// - returns: return an element V or nil if decoding failed
    public func decode<V>(_ key: String) -> V? {
        return data[key] as? V
    }
    
    private func _decodeDecodable<T: Decodable>(
        _ data: [String : AnyObject]) -> T? {
        return T.decode(with: Decoder(data: data))
    }
}

public final class Decoder : DecoderType {
    
    public var data = [String : AnyObject]()
    
    /// initialize a new decoder with data
    /// - parameter data: a dictionary to use for decoding
    /// - returns: returns a decoder
    public init(data: [String : AnyObject]) {
        self.data = data
    }
}
// MARK: - Functions

func sequence<T>(_ array: [T?]) -> [T]? {
    return  array.reduce(.some([])) { accum, elem in
        guard let accum = accum, elem = elem else { return nil }
        return accum + [elem]
    }
}

func sequence<T>(_ dictionary: [String: T?]) -> [String: T]? {
    return dictionary.reduce(.some([:])) { accum, elem in
        guard let accum = accum, value = elem.1 else { return nil }
        var result = accum
        result[elem.0] = value
        return result
    }
}

extension Dictionary {
    
     func map<A>(_ transform: (Value) -> A) -> [Key: A] {
        return self.reduce([:]) { accum, elem in
            var result = accum
            result[elem.0] = transform(elem.1)
            return result
        }
    }
}

/// binary Plist data format
/// base class for all data services. (see JSON, and Plist)
class Formatter {
    
    /// write data to a file
    /// - returns: true if succeeded, false if failed
    func write(_ object: [String : AnyObject], to url: URL) -> Bool  {
        if let data = makeData(from: object, prettyPrint: true) {
            return ((try? data.write(to: url, options: [.dataWritingAtomic] )) != nil)
        }
        else {
            return false
        }
    }
    

    /// write data to  NSData
    /// - returns: NSData or nil if failed
    func makeData(from object: [String : AnyObject],
                  prettyPrint: Bool) -> Data?  {
        return NSKeyedArchiver.archivedData(withRootObject: object)
    }
    
    /// write data to String
    /// - returns: a string or nil if failed
    func makeString(from object: [String : AnyObject]) -> String? {
        if let data = makeData(from: object, prettyPrint: true) {
            return NSString(data: data, encoding: String.Encoding.utf8.rawValue) as? String
        } else {
            return nil
        }
    }
    
    /// Read data from NSData
    /// - returns: a data object or nil
    func read(_ data: Data) -> [String : AnyObject]? {
        return NSKeyedUnarchiver.unarchiveObject(with: data) as? [String : AnyObject]
    }
    
    /// Read file from a URL
    /// - returns: a data object or nil
    func read(_ url: URL) -> [String : AnyObject]? {
        if let data = try? Data(contentsOf: url) {
            return read(data)
        }
        return nil
    }
    
    /// Read data from a string
    /// - returns: a data object or nil
    func read(_ content: String) -> [String : AnyObject]? {
        guard let data = makeData(from: content) else { return nil }
        return read(data)
    }
    
    func makeData(from string : String) -> Data? {
        return string.data(using: String.Encoding.utf8,
                           allowLossyConversion: true)
    }
}

/// JSON serialization format
final class JSONFormatter: Formatter {
    
    override func read(_ data: Data) -> [String : AnyObject]? {
        do {
            let o: AnyObject =  try JSONSerialization.jsonObject(
                with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            return o as? [String : AnyObject]
        } catch let error as NSError {
            Swift.print(error)
            return nil
        }
    }
    
    override func makeData(from object: [String : AnyObject],
                           prettyPrint: Bool) -> Data?  {
        
        guard JSONSerialization.isValidJSONObject(object) else {
            return nil
        }
        
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

/// XML Plist serialization format
final class PlistFormatter: Formatter {
    
    override func read(_ data: Data) -> [String : AnyObject]? {
        
        do {
            
            let o: AnyObject =
                try PropertyListSerialization.propertyList(
                    from: data, options:[.mutableContainersAndLeaves], format:nil
            )
            
            return o as? [String : AnyObject]
        } catch let error as NSError {
            
            Swift.print(error)
            return nil
        }
    }
    
    override func read(_ content: String) -> [String : AnyObject]? {
        let s = content as NSString
        return s.propertyList() as? [String : AnyObject]
    }
    
    
    override func makeData(from object: [String : AnyObject],
                           prettyPrint: Bool) -> Data?  {
        
        guard PropertyListSerialization.propertyList(
            object, isValidFor: PropertyListSerialization.PropertyListFormat.xmlFormat_v1_0) else {
                return nil
        }
        
        do {
            
            let data: Data? = try PropertyListSerialization.data(
                fromPropertyList: object, format: PropertyListSerialization.PropertyListFormat.xmlFormat_v1_0, options: .allZeros
            )
            
            return data
        } catch let error as NSError {
            
            Swift.print(error)
        }
        return nil
    }
}
