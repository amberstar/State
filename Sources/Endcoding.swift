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
    
    func encodeToFile(converter: Converter.Type, path: String) {
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

extension KVEncoder {
    public func encode<T: Encodable>(value: T?, _ key: String) {
        value.apply { self.data[key] = $0.encode() }
    }
    
    public func encode<T: Encodable>(value: [T]?, _ key: String) {
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