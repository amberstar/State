
/*****************************************************************************
Encoder:

encode models to key value data

******************************************************************************/

public final class Encoder {
    internal private(set) var data = [String : AnyObject]()
    
    public class func encode<T: Encodable>(element: T) -> [String : AnyObject] {
            let coder = Encoder()
            element.encode(coder)
            return coder.data
    }
    
    public func encode<T: Encodable>(element: T?, forKey key: String) {
        if let e = element {
            data[key] = Encoder.encode(e)
        }
    }
    
    public  func encode<T: Encodable>(element: [T]?, forKey key: String) {
        if let e = element {
            data[key] = e.map{ Encoder.encode($0) }
        }
    }
    
    public func encode<T: Encodable>(element: [String : T]?, forKey key: String) {
        if let e = element {
            data[key] = e.map{ Encoder.encode($0) }
        }
    }
    
    public func encode<V>(element: V?, forKey key: String) {
        if let e = element {
            data[key] = element as? AnyObject
        }
    }
    
    public func encode<V>(element: [V]?, forKey key: String) {
        if let e = element {
            data[key] = element as? AnyObject
        }
    }
    
    public func endcode<V>(element: [String : V]?, forKey key: String) {
        if let e = element {
            data[key] = element as? AnyObject
        }
    }
}