
/******************************************************************************
Decoder: 

decode key value data to models

******************************************************************************/
public final class Decoder {
    private var data = [String : AnyObject]()
    
    /**
    decode a decodable element from a dictionary
    - all non-optional properties must exist in the data
    :param: data a dictionary to use for decoding
    :returns: returns a decodable of type T or nil if decoding failed
    */
    public class func decode<T: Decodable>(data:[String : AnyObject]) -> T? {
        var decoder = Decoder(data: data)
        return T(decoder: decoder)
        //return T.decode(decoder)
    }
    
    /**
    decode a decodable element from AnyObject?
    - will cast data to a dictionary and call decode(data: [String : AnyObject])
    :param: data must be cast-able to a Dictionary<String, AnyObject>
    :returns: returns a decodable of type T or nil if decoding failed
    */
    public class func decode<T:Decodable>(data: AnyObject?) -> T? {
        switch data {
        case let .Some(d):
            if let ud = d as? [String : AnyObject] {
                return self.decode(ud)
            }
            return nil
        default:
            return nil
        }
    }
    
    /**
    initialize a new decoder with data
    - data is stored for decoding
    :param: data a dictionary to use for decoding
    :returns: returns a decoder
    */
    public init(data: [String : AnyObject]) {
        self.data = data
    }

    /**
    decode a decodable element
    :param: key a dictionary to use for decoding
    :returns: return element of type T or nil if decoding failed
    */
    public func decodeObject<T:Decodable>(key: String) -> T? {
        return _decodeDecodable(key)
    }
    
    /**
    decode an optional decodable element
    :param: key a dictionary to use for decoding
    :returns: return an optional element type T optional
    */
    public func decodeOptionalObject<T:Decodable>(key: String) -> T?? {
        return Optional(_decodeDecodable(key))
    }
    
    /**
    decode a decodable array of element T
    :param: key a dictionary to use for decoding
    :returns: return an optional array of T or nil if decoding failed
    */
    public func decodeObjectArray<T:Decodable>(key: String) -> [T]? {
        return _decodeDecodableArray(key)
    }
    
    /**
    decode an optional decodable array optional of element T
    :param: key a dictionary to use for decoding
    :returns: return an optional array of  element T optional
    */
    public func decodeOptionalObjectArray<T: Decodable>(key: String) -> [T]?? {
        return Optional(_decodeDecodableArray(key))
    }
    
    /**
    decode a dictionary of string,decodable element T
    :param: key a dictionary to use for decoding
    :returns: return a dictionary of string, element T or nil if decoding failed
    */
    public func decodeObjectDictionary<T: Decodable>(key: String) -> [String : T]? {
        return _decodeDecodableDictionary(key)
    }
    
    /**
    decode an optional dictionary of string,decodable element T
    :param: key a dictionary to use for decoding
    :returns: return an optional dictionary string, element T optional
    */
    public func decodeOptionalObjectDictionary<T: Decodable>(key: String) -> [String : T]?? {
        return Optional(_decodeDecodableDictionary(key))
    }
    
    /**
    decode a value element V
    :param: key a dictionary to use for decoding
    :returns: return an element V or nil if decoding failed
    */
    public func decode<V>(key: String) -> V? {
        return _decode(key)
    }
    
    /**
    decode an optional value element V
    :param: key a dictionary to use for decoding
    :returns: return an optional element V optional
    */
    public func decodeOptional<V>(key: String) -> V?? {
        return Optional(_decode(key))
    }
    
    /**
    decode a value array element V
    :param: key a dictionary to use for decoding
    :returns: return an array of element V or nil if decoding failed
    */
    public func decodeArray<V>(key: String) -> [V]? {
        return _decodeArray(key)
    }
    
    /**
    decode an optional value array element V
    :param: key a dictionary to use for decoding
    :returns: return an optional array of element V optional
    */
    public func decodeOptionalArray<V>(key: String) -> [V]??  {
        return Optional(_decodeArray(key))
    }
    
    /**
    decode an value dictionary of string, element V
    :param: key a dictionary to use for decoding
    :returns: return a dictionary of element V or nil if decoding failed
    */
    public func decodeDictionary<V>(key: String) -> [String : V]? {
        return _decodeDictionary(key)
    }
    
    /**
    decode an optional value dictionary of string, element V
    :param: key a dictionary to use for decoding
    :returns: return an optional dictionary of element V optional
    */
    public func decodeOptionalDictionary<V>(key: String) -> [String : V]??  {
        return Optional(_decodeDictionary(key))
    }
    
/************************************************************************************************

///MARK: - PRIVATE METHODS

************************************************************************************************/
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
    
    private func _decodeArray<V>(key: String) -> [V]? {
        if let d = data[key] as? [AnyObject] {
            return sequence(d.map{ $0 as? V })
        }
        return nil
    }
    
    private func _decodeDictionary<V>(key: String) -> [String : V]? {
        if let d = data[key] as? [String : AnyObject] {
            return sequence(d.map{ $0 as? V })
        }
        return nil
    }
}