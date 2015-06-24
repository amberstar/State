
public protocol Encodable {
    func encode(data: Encoder)
}

public extension Encodable {
    
    func encode() -> [String : AnyObject] {
        let coder = Encoder()
        self.encode(coder)
        return coder.data
    }
    
    func encodeToFile(format: DataFormat.Type, path: String) {
        format.write(self.encode(), path: path)
    }
    
    func encodeToJSONFile(path: String) {
        self.encodeToFile(JSON.self, path: path)
    }
    
    func encodeToPlistFile(path: String) {
        self.encodeToFile(Plist.self, path: path)
    }
    
    func encodeToBinaryFile(path: String) {
        self.encodeToFile(Binary.self, path: path)
    }
    
}

public final class Encoder {
    internal private(set) var data = [String : AnyObject]()
    
    public func encode<T: Encodable>(element: T?, forKey key: String) {
        element.flatMap { self.data[key] = $0.encode() }
    }
    
    public  func encode<T: Encodable>(element: [T]?, forKey key: String) {
           element.flatMap { self.data[key] = $0.map { $0.encode() } }
    }
 
    public func encode<T: Encodable>(element: [String : T]?, forKey key: String) {
        element.flatMap { self.data[key] = $0.map { $0.encode() } }
    }
    
    public func encode<V>(element: V?, forKey key: String) {
        element.flatMap{ self.data[key] = $0 as? AnyObject }
    }
}