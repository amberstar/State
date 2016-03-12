
/// A KVStore is a general purpose store for models and values
public struct KVStore : KVEncoder, KVDecoder {
    
    /// The key value data of the store
    public var data = [String : AnyObject]()
    
    /// Initialize a new KVStore with data
    public init(data: [String : AnyObject] = [:]) {
        self.data = data
    }
    
    /// Initialize a new store from a file
    public init?(_ format: Format, path: String) {
        
        if let d =  format.converter.read(path) {
            self.data = d
        } else { return nil }
    }
    
    /// Save store to a file
    public func save(format: Format, path: String) -> Bool {
        return format.converter.write(self.data, path: path)
    }
    
    /// Returns a value at key or nil
    public func get<T where T: Model>(key: String) -> T? {
        return self.decodeModel(key)
    }
    
    /// Returns a value at key or nil
    public func get<T where T: Model>(key: String) -> [T]? {
        return self.decodeModelArray(key)
    }
    
    /// Returns a value at key or nil
    public func get<T where T: Model>(key: String) -> [String : T]? {
        return self.decodeModelDictionary(key)
    }
    
    /// Returns a value at key or nil
    public func get<T>(key: String) -> T? {
        return self.decode(key)
    }
    
    /// Set or update the value at key
    public mutating func set<T>(value: T, _ key: String) {
        self.encode(value, key)
    }
    
    /// Set or update the value at key
    public mutating func set<T where T: Model>(value: T, _ key: String) {
        self.encode(value, key)
    }
    
    /// Set or update the value at key
    public mutating func set<T where T: Model>(value: [T], _ key: String) {
        self.encode(value, key)
    }
    
    /// Set or update the value at key
    public mutating func set<T where T: Model>(value: [String : T], _ key: String) {
        self.encode(value, key)
    }
}