
public protocol Encodable {
    func encode(encoder: Encoder)
}

public final class Encoder {
    internal private(set) var data = [String : AnyObject]()
    
    /// Encode model to a dictionary
    public class func encodeModel<T: Encodable>(element: T) -> [String : AnyObject] {
        let coder = Encoder()
        element.encode(coder)
        return coder.data
    }
    
    public func encode<T: Encodable>(element: T?)(forKey key: String) {
        if let e = element {
            data[key] = Encoder.encodeModel(e)
        }
    }
    
    public func encode<T: Encodable>(element: T?, forKey key: String) {
        if let e = element {
            data[key] = Encoder.encodeModel(e)
        }
    }
    
    public func encode<T: Encodable>(element: [T]?)(forKey key: String) {
        if let e = element {
            data[key] = e.map{ Encoder.encodeModel($0) }
        }
    }
    
    public  func encode<T: Encodable>(element: [T]?, forKey key: String) {
        if let e = element {
            data[key] = e.map{ Encoder.encodeModel($0) }
        }
    }
    
    public func encode<T: Encodable>(element: [String : T]?)(forKey key: String) {
        if let e = element {
            data[key] = e.map{ Encoder.encodeModel($0) }
        }
    }
    
    public func encode<T: Encodable>(element: [String : T]?, forKey key: String) {
        if let e = element {
            data[key] = e.map{ Encoder.encodeModel($0) }
        }
    }
    
    public func encode<V>(element: V?)(forKey key: String) {
        if let _ = element {
            data[key] = element as? AnyObject
        }
    }
    
    public func encode<V>(element: V?, forKey key: String) {
        if let _ = element {
            data[key] = element as? AnyObject
        }
    }
}