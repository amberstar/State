
let KVStoreVersion = "1.0"
let KVStoreVersionKey  = "KVStore.Version"

/// A KVStore is a general purpose store for models and values
public class KVStoreContainer : KVEncoder, KVDecoder {
    
    
    var path: String?
    
    /// The key value data of the store
    public var data = [String : AnyObject]() {
        didSet {
            if let path = self.path {
                //saveStore(store, path)
            }
        }
    }
    
    /// Initialize a new KVStore with data
    public init(data: [String : AnyObject] =  [:]) {
        self.data = data
        set(value: KVStoreVersionKey, forKey: KVStoreVersion)
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
    
    public func getBool(forKey key: String) -> Bool? {
        return getValue(forKey: key)
    }
    
    public func getInt(forKey key: String) -> Int? {
        return getValue(forKey: key)
    }
    
    public func getDouble(forKey key: String) -> Double? {
         return getValue(forKey: key)
    }
    
    public func getFloat(forKey key: String) -> Float? {
         return getValue(forKey: key)
    }
    
    public func getString(forKey key: String) -> String? {
         return getValue(forKey: key)
    }
    
    /// Returns a value at key or nil
    public func getValue<T where T: Model>(forKey key: String) -> T? {
        return self.decodeModel(key)
    }
    
    /// Returns a value at key or nil
    public func getValue<T where T: Model>(forKey key: String) -> [T]? {
        return self.decodeModelArray(key)
    }
    
    /// Returns a value at key or nil
    public func getValue<T where T: Model>(forKey key: String) -> [String : T]? {
        return self.decodeModelDictionary(key)
    }
    
    /// Returns a value at key or nil
    public func getValue<T>(forKey key: String) -> T? {
        return self.decode(key)
    }
    
    /// Set or update the value at key
    public func set<T>(value value: T, forKey key: String) {
        self.encode(value, key)
    }
    
    /// Set or update the value at key
    public func set<T where T: Model>(value value: T , forKey key: String ) {
        self.encode(value, key)
    }
    
    /// Set or update the value at key
    public  func set<T where T: Model>(value value: [T], forKey key: String) {
        self.encode(value, key)
    }
    
    /// Set or update the value at key
    public func set<T where T: Model>(value value: [String : T], forKey key: String) {
        self.encode(value, key)
    }
    
    /// Merge a store into the receiver store
    /// adding or updating any values
    public func merge(store: KVStoreContainer) {
        self.data.merge(store.data)
    }
}