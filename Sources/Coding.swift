public protocol Encodable {
    func encode(encoder: Encoder)
    func willFinishEncodingWithEncoder(encoder: Encoder)
}

public extension Encodable {
    
    func encode() -> [String : AnyObject] {
        let coder = Encoder()
        self.encode(coder)
        return coder.data
    }
    
    func encodeToFile(converter: KeyedConverter.Type, path: String) {
        converter.write(self.encode(), path: path)
    }
    
    /**
     encoding will finish on the receiver
     - parameter encoder: the encoder used for encoding
     
     :Discussion: This method is called right before encoding finishes.
     It provides a chance to encode any further data with the encoder.
     */
    func willFinishEncodingWithEncoder(encoder: Encoder) {
        
    }
}

public protocol KVEncoder : class {
    var data : [String : AnyObject] { get set }
}

extension KVEncoder  {
    public func encode<T: Encodable>(value: T?, _ key: String) {
        value.apply { self.data[key] = $0.encode() }
    }
    
    public  func encode<T: Encodable>(value: [T]?, _ key: String) {
        value.apply { self.data[key] = $0.map { $0.encode() } }
    }
    
    public func encode<T: Encodable>(value: [String : T]?, _ key: String) {
        value.apply { self.data[key] = $0.map { $0.encode() } }
    }
    
    public func encode<V>(value: V?, _ key: String) {
        value.apply{ self.data[key] = $0 as? AnyObject }
    }
}

public final class Encoder : KVEncoder {
    public var data = [String : AnyObject]()
}

public protocol Decodable {
    init?(decoder: Decoder)
    func didFinishDecodingWithDecoder(decoder: Decoder)
}

public extension Decodable {
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
    
    public static func decodeFromFile(converter: KeyedConverter.Type, path: String) -> Self? {
        return decode(converter.read(path))
    }
    
    /**
     decoding is finished on the receiver
     - parameter decoder: the decoder used for decoding
     
     :Discussion: This method is called after decoding takes place.
     It provides a way to decode any further data with the decoder
     or to do any initialization needed after decoding.
     */
    func didFinishDecodingWithDecoder(decoder: Decoder) {
        
    }
}

public protocol KVDecoder {
    var data :[String : AnyObject] { get set }
}

extension KVDecoder {
    
    /// decode a decodable element
    /// - parameter key: a dictionary to use for decoding
    /// - returns: return element of type T or nil if decoding failed
    public func decodeModel<T:Decodable>(key: String) -> T? {
        let d = data[key] as? [String : AnyObject]
        return d.flatMap(_decodeDecodable)
    }
    
    /// decode a decodable array of element T
    /// - parameter key: a dictionary to use for decoding
    /// - returns: return an optional array of T or nil if decoding failed
    public func decodeModelArray<T:Decodable>(key: String) -> [T]? {
        let d = data[key] as? [[String : AnyObject]]
        return d.flatMap { sequence($0.map( _decodeDecodable)) }
    }
    
    /// decode a dictionary of string,decodable element T
    /// - parameter key: a dictionary to use for decoding
    /// - returns: return a dictionary of string, element T or nil if decoding failed
    public func decodeModelDictionary<T: Decodable>(key: String) -> [String : T]? {
        let d = data[key] as? [String : [String : AnyObject]]
        return d.flatMap { sequence($0.map(_decodeDecodable)) }
    }
    
    
    /// decode a value element V
    /// - parameter key: a dictionary to use for decoding
    /// - returns: return an element V or nil if decoding failed
    public func decode<V>(key: String) -> V? {
        return data[key] as? V
    }
    
    public func extractData() -> [String : AnyObject] {
        return self.data
    }
    
    private func _decodeDecodable<T: Decodable>(data: [String : AnyObject]) -> T? {
        return T(decoder: Decoder(data: data))
    }
}

public final class Decoder : KVDecoder {
     public var data = [String : AnyObject]()
    
    /// initialize a new decoder with data
    /// - parameter data: a dictionary to use for decoding
    /// - returns: returns a decoder
    public init(data: [String : AnyObject]) {
        self.data = data
    }

}