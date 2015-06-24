
public protocol Decodable {
    init?(decoder: Decoder)
}

extension Decodable {
    public static func decode(data: [String : AnyObject]) -> Self? {
        let decoder = Decoder(data: data)
        return Self.init(decoder: decoder)
    }
    
    public static func decode(data: AnyObject?) -> Self? {
        if let data = data as? [String : AnyObject] {
            return Self.decode(data)
        }
        return nil 
    }
    
    public static func decodeFromFile(format: DataFormat.Type, path: String) -> Self? {
        return decode(format.read(path))
    }
    
    public static func decodeFromJSONFile(path: String) -> Self? {
        return decodeFromFile(JSON.self, path: path)
    }
    
    public static func decodeFromPlistFile(path: String) -> Self? {
        return decodeFromFile(Plist.self, path: path)
    }
    
    public static func decodeFromBinaryFile(path: String) -> Self? {
        return decodeFromFile(Binary.self, path: path)
    }
}

public final class Decoder {
    private var data = [String : AnyObject]()
    
    /// initialize a new decoder with data
    /// - parameter data: a dictionary to use for decoding
    /// - returns: returns a decoder
    public init(data: [String : AnyObject]) {
        self.data = data
    }

    /// decode a decodable element
    /// - parameter key: a dictionary to use for decoding
    /// - returns: return element of type T or nil if decoding failed
    public func decodeModel<T:Decodable>(key: String) -> T? {
        return _decodeDecodable(key)
    }
    
    /// decode a decodable array of element T
    /// - parameter key: a dictionary to use for decoding
    /// - returns: return an optional array of T or nil if decoding failed
    public func decodeModelArray<T:Decodable>(key: String) -> [T]? {
        return _decodeDecodableArray(key)
    }
    
    /// decode a dictionary of string,decodable element T
    /// - parameter key: a dictionary to use for decoding
    /// - returns: return a dictionary of string, element T or nil if decoding failed
    public func decodeModelDictionary<T: Decodable>(key: String) -> [String : T]? {
        return _decodeDecodableDictionary(key)
    }
    
    /// decode a value element V
    /// - parameter key: a dictionary to use for decoding
    /// - returns: return an element V or nil if decoding failed
    public func decode<V>(key: String) -> V? {
        return _decode(key)
    }
    
    public func extractData() -> [String : AnyObject] {
        return self.data
    }
    
// MARK: - PRIVATE METHODS

    private func _decodeDecodable<T: Decodable>(key: String) -> T? {
        if let d = data[key] as? [String : AnyObject] {
            let decoded: T? = T(decoder: Decoder(data: d))
            return decoded
        }
        return nil
    }
    private func _decodeDecodableArray<T: Decodable>(key: String) -> [T]? {
        if let d = data[key] as? [[String : AnyObject]] {
            return sequence(d.map{
                let decoded: T? = T(decoder: Decoder(data: $0))
                return decoded
                })
        }
        return nil
    }
    
    private func _decodeDecodableDictionary<T: Decodable>(key: String) -> [String : T]? {
        if let d = data[key] as? [String :[String : AnyObject]] {
            return sequence(d.map{
                let decoded: T? = T(decoder: Decoder(data: $0))
                return decoded
                })
        }
        return nil
    }
    
    private func _decode<V>(key: String) -> V? {
        if let d = data[key] as? V  {
            return d
        }
        return nil
    }
}