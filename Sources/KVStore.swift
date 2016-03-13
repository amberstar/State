
let KVStoreVersion = "1.0"
let KVStoreVersionKey  = "KVStore.Version"

/// A KVStore is a general purpose store for models and values
public struct KVStore : KVEncoder, KVDecoder {
    
    /// The key value data of the store
    public var data = [String : AnyObject]()
    
    /// Initialize a new KVStore with data
    public init(data: [String : AnyObject] =  [:]) {
        self.data = data
        setValue(KVStoreVersionKey, KVStoreVersion)
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
    
    public func boolValue(key: String) -> Bool? {
        return value(key)
    }
    
    public func intValue(key: String) -> Int? {
        return value(key)
    }
    
    public func doubleValue(key: String) -> Double? {
        return value(key)
    }
    
    public func floatValue(key: String) -> Float? {
        return value(key)
    }
    
    public func stringValue(key: String) -> String? {
        return value(key)
    }
    
    /// Returns a value at key or nil
    public func value<T where T: Model>(key: String) -> T? {
        return self.decodeModel(key)
    }
    
    /// Returns a value at key or nil
    public func value<T where T: Model>(key: String) -> [T]? {
        return self.decodeModelArray(key)
    }
    
    /// Returns a value at key or nil
    public func value<T where T: Model>(key: String) -> [String : T]? {
        return self.decodeModelDictionary(key)
    }
    
    /// Returns a value at key or nil
    public func value<T>(key: String) -> T? {
        return self.decode(key)
    }
    
    /// Set or update the value at key
    public mutating func setValue<T>(key: String, _ value: T) {
        self.encode(value, key)
    }
    
    /// Set or update the value at key
    public mutating func setValue<T where T: Model>(key: String, _ value: T ) {
        self.encode(value, key)
    }
    
    /// Set or update the value at key
    public mutating func setValue<T where T: Model>(key: String, _ value: [T]) {
        self.encode(value, key)
    }
    
    /// Set or update the value at key
    public mutating func setValue<T where T: Model>(key: String, _ value: [String : T]) {
        self.encode(value, key)
    }
    
    /// Merge a store into the receiver store
    /// adding or updating any values
    public mutating func merge(store: KVStore) {
        self.data.merge(store.data)
    }
}