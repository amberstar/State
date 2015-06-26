public protocol Encodable {
    func encode(encoder: Encoder)
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
}

public final class Encoder {
    internal private(set) var data = [String : AnyObject]()
    
    public func encode<T: Encodable>(element: T?, _ key: String) {
        element.flatMap { self.data[key] = $0.encode() }
    }
    
    public  func encode<T: Encodable>(element: [T]?, _ key: String) {
        element.flatMap { self.data[key] = $0.map { $0.encode() } }
    }
    
    public func encode<T: Encodable>(element: [String : T]?, _ key: String) {
        element.flatMap { self.data[key] = $0.map { $0.encode() } }
    }
    
    public func encode<V>(element: V?, _ key: String) {
        element.flatMap{ self.data[key] = $0 as? AnyObject }
    }
}