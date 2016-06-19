import Foundation

let KeypathSeperator : Character = "."
let StoreKey = "KEYS"
let DataKey = "VALUES"
let KVStoreVersionKey = "VERSION"
let KVStoreVersion = 1

public enum KVStoreError : ErrorProtocol {
    case keyNotFound(String)
    case noResult
}

/// A KVStore is a general purpose key-value store for arbitrary values.
public final class KVStore: Encodable, Decodable, EncoderType, DecoderType {
    
    public private(set) var keys : [String : KVStore] = [:]
    public var data = [String : AnyObject]()
    
    /// Initialize a new Store with the specified value and key dictionaries
    public init(values: [String : AnyObject] =  [:], keys: [String : KVStore] = [:]) {
        data = values
        self.keys = keys
    }
    
    public func save(_ path: String) {
        save(.plist, path: path)
    }
    
    public static func load(_ path: String) -> KVStore? {
        return KVStore.decodeFromFile(Format.plist.converter, path: path)
    }
    
    public static func load(_ data: Data) -> KVStore? {
        return decode(Format.plist.converter.read(data))
    }
    
    //****************************************************************************//
    // MARK: Coding
    //****************************************************************************//
    
    public func encode(_ encoder: Encoder) {
        
        if data.count > 0 {
            encoder.encode(data, DataKey)
        }
        
        if keys.count > 0 {
            encoder.encode(keys, StoreKey)
        }
    }
    
    public static func decode(_ decoder: Decoder) -> KVStore? {
        let stores : [String : KVStore]? = decoder.decode(StoreKey)
        let data : [String : AnyObject]? = decoder.decode(DataKey)
        
        let result = self.init(values: data ?? [:], keys: stores ?? [:])
        
        return result
    }
    //****************************************************************************//
    // MARK: Keys - Creating, Getting, Updating
    //****************************************************************************//
    
    /// Return the key at the keypath
    /// or nil if not found
    public func getKey(_ keypath: String)  ->  KVStore? {
        let editor: (KVStore) -> KVStore = { store in
            return store
        }
        let onMissingKey : (KVStore, String) throws -> KVStore? = { store, key in
            return nil
        }
        
        do {
            return try edit(splitKeypath(keypath),  editor: editor, onMissingKey: onMissingKey)
        }
        catch {
            return nil
        }
    }
    
    /// Adds or returns an existing key with the specified path to the reciever
    ///
    /// - note: any intermediate keys are created
    /// - returns: key created or found
    public func addKey(_ keypath: String) -> KVStore {
        var keyNames: [String] = splitKeypath(keypath)
        let keyName: String = keyNames.removeLast()
        
        func addNewKeyToKey(_ key: KVStore, name: String) -> KVStore {
            let newStore = KVStore()
            key.keys[name] = newStore
            return newStore
        }
        
        // if key already exsists return it
        if let key = getKey(keypath) {
            return key
        }
        else {
            let editor: (KVStore) throws -> KVStore = { key in
                return addNewKeyToKey(key, name: keyName)
            }
            let onMissingKey: (KVStore, String) -> KVStore? = { key, keyName in
                return addNewKeyToKey(key, name: keyName)
            }
            
            do {
                return try edit(keyNames, editor: editor, onMissingKey: onMissingKey)
            }
            catch {
                fatalError("Could not create key \(keypath)")
            }
        }
    }
    
    /// Updates the key at with the specified name, or adds it
    /// if it doesn't already exsist.
    ///
    /// - returns : the key that was replaced or nil if the newKey was added
    public func updateKey(_ keypath: String, newKey key: KVStore) -> KVStore? {
        let keys = seperateKeypath(keypath)
        let targetKey = keys.keypath == nil ? self : addKey(keys.keypath!)
        
        return targetKey.keys.updateValue(key, forKey: keys.valueName)
    }
    
    /// Removes the key at `keypath` and returns it or
    /// returns nil if not found.
    public func removeKey(_ keypath: String) -> KVStore? {
        var keyNames = splitKeypath(keypath)
        let keyName = keyNames.removeLast()
        let editor : (KVStore) -> KVStore? = { key in
            return key.keys.removeValue(forKey: keyName)
        }
        let onMissingKey : (KVStore, String) throws -> KVStore? = { store, key in
            print("Key not found, Invalid Key: \(keypath) Key: \(key)")
            return nil
        }
        
        do {
            let result : KVStore? =  try edit(keyNames, editor: editor, onMissingKey: onMissingKey)
            return result
            
        }
        catch {
            return nil
        }
    }
    
    //****************************************************************************//
    // MARK: Merging Stores
    //****************************************************************************//
    
    /// Merges the sourceKey with the key specified at keypath
    /// - returns : the mergedKey
    public func merge(_ source: KVStore, intoKeypath: String  ) -> KVStore {
        let targetKey = addKey(intoKeypath)
        return targetKey.merge(source)
    }
    
    /// Deep merges the sourceKey into the reciever
    public func merge(_ source: KVStore) -> KVStore {
        data.merge(source.data)
        
        for entry in source.keys {
            // if we already have this key, merge them
            if let targetKey = keys[entry.0] {
                targetKey.merge(entry.1)
            }
                // else add the key
            else {
                keys[entry.0] = entry.1
            }
        }
        return self
    }
    
    //****************************************************************************//
    // MARK: Setters
    //****************************************************************************//
    
    public func setValue<V: Encodable>(_ value: V, forKey: String) {
        let keys = seperateKeypath(forKey)
        
        let targetKey = keys.keypath == nil  ? self : addKey(keys.keypath!)
        targetKey.encode(value, keys.valueName)
        
    }
    
    public func setValue<T: Encodable>(_ value: [T], forKey: String) {
        let keys = seperateKeypath(forKey)
        
        let targetKey = keys.keypath == nil  ? self : addKey(keys.keypath!)
        targetKey.encode(value, keys.valueName)
    }
    
    public func setValue<T: Encodable>(_ value: [String : T], forKey: String) {
        let keys = seperateKeypath(forKey)
        
        let targetKey = keys.keypath == nil  ? self : addKey(keys.keypath!)
        targetKey.encode(value, keys.valueName)
    }
    
    public func setValue<V>(_ value: V, forKey: String) {
        let keys = seperateKeypath(forKey)
        
        let targetKey = keys.keypath == nil  ? self : addKey(keys.keypath!)
        targetKey.encode(value, keys.valueName)
    }
    
    //****************************************************************************//
    // MARK: Getters
    //****************************************************************************//
    
    public func getValue<T>(forKey key: String) -> T? {
        let keys = seperateKeypath(key)
        let targetKey = keys.keypath == nil ? self : getKey(keys.keypath!)
        
        if let targetKey = targetKey {
            return targetKey.decode(keys.valueName)
        }
        else {
            return nil
        }
    }
    
    public func getValue<T: Decodable>(forKey key: String) -> T? {
        let keys = seperateKeypath(key)
        let targetKey = keys.keypath == nil ? self : getKey(keys.keypath!)
        
        if let targetKey = targetKey {
            return targetKey.decode(keys.valueName)
        }
        else {
            return nil
        }
    }
    
    public func getValue<T: Decodable>(forKey key: String) -> [T]? {
        let keys = seperateKeypath(key)
        let targetKey = keys.keypath == nil ? self : getKey(keys.keypath!)
        
        if let targetKey = targetKey {
            return targetKey.decode(keys.valueName)
        }
        else {
            return nil
        }
    }
    
    public func getValue<T: Decodable>(forKey key: String) -> [String : T]? {
        let keys = seperateKeypath(key)
        let targetKey = keys.keypath == nil ? self : getKey(keys.keypath!)
        
        if let targetKey = targetKey {
            return targetKey.decode(keys.valueName)
        }
        else {
            return nil
        }
    }
    
    //****************************************************************************//
    // MARK: Basic Getters
    //****************************************************************************//
    
    /// Returns a Bool at key or nil
    public func getBool(forKey key: String) -> Bool? {
        return getValue(forKey: key)
    }
    
    /// Returns a Int at key or nil
    public func getInt(forKey key: String) -> Int? {
        return getValue(forKey: key)
    }
    
    /// Returns a double at key or nil
    public func getDouble(forKey key: String) -> Double? {
        return getValue(forKey: key)
    }
    
    /// Returns a Float at key or nil
    public func getFloat(forKey key: String) -> Float? {
        return getValue(forKey: key)
    }
    
    /// Returns a String at key or nil
    public func getString(forKey key: String) -> String? {
        return getValue(forKey: key)
    }
    
    //****************************************************************************//
    // MARK: Getters with default values
    //****************************************************************************//
    
    public func getBool(forKey key: String , defaultValue: Bool) -> Bool {
        return getValue(forKey: key) ?? defaultValue
    }
    
    public func getInt(forKey key: String, defaultValue: Int) -> Int {
        return getValue(forKey: key) ?? defaultValue
    }
    
    public func getDouble(forKey key: String, defaultValue: Double) -> Double {
        return getValue(forKey: key) ?? defaultValue
    }
    
    public func getFloat(forKey key: String,  defaultValue: Float) -> Float {
        return getValue(forKey: key) ?? defaultValue
    }
    
    public func getString(forKey key: String, defaultValue: String) -> String {
        return getValue(forKey: key) ?? defaultValue
    }
    
    public func getValue<T>(forKey key: String, defaultValue: T) -> T {
        return getValue(forKey: key) ?? defaultValue
    }
    
    public func getValue<T: Decodable>(forKey key: String, defaultValue: T) -> T {
        return getValue(forKey: key) ?? defaultValue
    }
    
    public func getValue<T: Decodable>(forKey key: String, defaultValue: [T]) -> [T] {
        return getValue(forKey: key) ?? defaultValue
    }
    
    public func getValue<T: Decodable>(forKey key: String,  defaultValue: [String : T]
        ) -> [String : T] {
        return getValue(forKey: key) ?? defaultValue
    }
    
    //****************************************************************************//
    // MARK: Removal
    //****************************************************************************//
    
    /// Removes a value at key and returns it,
    /// or returns nil if not found
    public func removeValue<T>(_ key: String) -> T? {
        return removeValue(key) { store, valueName in
            return store.decode(valueName)
        }
    }
    
    /// Removes a value at key and returns it,
    /// or returns nil if not found
    public func removeValue<T: Decodable>(_ key: String) -> T? {
        return removeValue(key) { store, valueName in
            return store.decode(valueName)
        }
    }
    
    /// Removes a value at key and returns it,
    /// or returns nil if not found
    public func removeValue<T: Decodable>(_ key: String) -> [T]? {
        return removeValue(key) { store, valueName in
            return store.decode(valueName)
        }
    }
    
    /// Removes a value at key and returns it,
    /// or returns nil if not found
    public func removeValue<T: Decodable>(_ key: String) -> [String : T]? {
        return removeValue(key) { store, valueName in
            return store.decode(valueName)
        }
    }
    
    /// Removes a value at key and returns it,
    /// or returns nil if not found
    func removeValue<T>(_ key: String, decode: (KVStore, String) ->  T? ) -> T? {
        let keys = seperateKeypath(key)
        let targetKey = keys.keypath == nil ? self : getKey(keys.keypath!)
        
        if let targetKey = targetKey {
            let value : T? =  decode(targetKey, keys.valueName)
            targetKey.data.removeValue(forKey: keys.valueName)
            return value
        }
        else {
            return nil
        }
    }
    
    /// Simillar to remove but does not return
    /// the value removed.
    public func deleteValue(_ key: String) {
        let keys = seperateKeypath(key)
        let targetKey = keys.keypath == nil ? self : getKey(keys.keypath!)
        
        if let targetKey = targetKey {
            targetKey.data.removeValue(forKey: keys.valueName)
        }
    }
}

//****************************************************************************//
// MARK: Implementations
//****************************************************************************//

extension KVStore {
    
    func walk(@noescape descend: (KVStore) throws -> KVStore?,
                        @noescape ascend: (KVStore, KVStore)  throws -> Void) rethrows -> Void {
        
        guard let child = try descend(self) else {
            return
        }
        try child.walk(descend: descend, ascend: ascend)
        try ascend(self, child)
    }
    
    func edit<V>(_ keys: [String], editor: (KVStore) throws -> V,
              onMissingKey: (KVStore, String) throws -> KVStore? ) throws -> V  {
        var keyGen = keys.makeIterator()
        var result : V? = nil
        
        try walk(
            descend:  { store in
                guard let nextKey = keyGen.next() else {
                    // bottom
                    result = try editor(store)
                    return nil
                }
                guard let next = store.keys[nextKey] else {
                    // we have an unrecognized key
                    return  try onMissingKey(store, nextKey)
                }
                return next
            },
            ascend: { _, _ in  }
        )
        
        if let result = result {
            return result
        } else {
            throw KVStoreError.noResult
        }
    }
}

extension Dictionary {
    /// Merges the dictionary with dictionaries passed. The latter dictionaries will override
    /// values of the keys that are already set
    ///
    /// :param dictionaries A comma seperated list of dictionaries
    mutating func merge<K, V>(_ dictionaries: Dictionary<K, V>...) {
        for dict in dictionaries {
            for (key, value) in dict {
                self.updateValue(value as! Value, forKey: key as! Key)
            }
        }
    }
}

///  Split keys into an array of strings
func splitKeypath(_ path: String) -> [String] {
    return path.characters.split(separator: ".").map(String.init)
}

/// Join keys with `KeypathSeperator`
func joinKeypath(_ keys: [String]) -> String {
    return keys.joined(separator: String(KeypathSeperator))
}

public func seperateKeypath(_ path: String) -> (keypath: String?, valueName: String) {
    var keys = splitKeypath(path)
    let key = keys.removeLast()
    let joinResult = joinKeypath(keys)
    let keypath : String? = joinResult.characters.count > 0 ? joinResult : nil
    return (keypath, key)
}
