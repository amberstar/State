
//
// State: Sources/KVStore.swift
// Copyright © 2016 SIMPLETOUCH LLC. All rights reserved.
//
// Licensed under The MIT License (MIT)
//

/// Status: Experimental
///
/// KVStore - A gerneral purpose key-value tree store
///
/// A KVStore can be used to store models as well as
/// arbitrary values.
/// 
/// Simillar to `UserDefaults` however A KVStore is 
/// arranged as a hierarchical set of
/// `key`s in which you can store items at any keypath
/// location.
///

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

public final class KVStore: ModelStore, Model, EncoderType, DecoderType {
    
    public private(set) var keys : [String : KVStore] = [:]
    public var data = [String : AnyObject]()
    
    /// Initialize a new Store with the specified value and key dictionaries
    public init(values: [String : AnyObject] =  [:], keys: [String : KVStore] = [:]) {
        data = values
        self.keys = keys
    }
    
// MARK: Encoding
    
    public func encode(with encoder: Encoder) {
        
        if data.count > 0 {
            encoder.encode(data, DataKey)
        }
        
        if keys.count > 0 {
            encoder.encode(keys, StoreKey)
        }
    }
    
    public static func decode(with decoder: Decoder) -> KVStore? {
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
            return try edit(path: split(keyPath: keypath),  editor: editor, onMissingKey: onMissingKey)
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
        var keyNames: [String] = split(keyPath: keypath)
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
                return try edit(path: keyNames, editor: editor, onMissingKey: onMissingKey)
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
        let keys = seperate(keyPath: keypath)
        let targetKey = keys.keypath == nil ? self : addKey(keys.keypath!)
        
        return targetKey.keys.updateValue(key, forKey: keys.valueName)
    }
    
    /// Removes the key at `keypath` and returns it or
    /// returns nil if not found.
    public func removeKey(_ keypath: String) -> KVStore? {
        var keyNames = split(keyPath: keypath)
        let keyName = keyNames.removeLast()
        let editor : (KVStore) -> KVStore? = { key in
            return key.keys.removeValue(forKey: keyName)
        }
        let onMissingKey : (KVStore, String) throws -> KVStore? = { store, key in
            print("Key not found, Invalid Key: \(keypath) Key: \(key)")
            return nil
        }
        
        do {
            let result : KVStore? =  try edit(path: keyNames, editor: editor, onMissingKey: onMissingKey)
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
    
    public func set<Model: Encodable>(_ model: Model, forKey keyPath: String) {
        let keys = seperate(keyPath: keyPath)
        
        let targetKey = keys.keypath == nil  ? self : addKey(keys.keypath!)
        targetKey.encode(model, keys.valueName)
    }
    
    public func set<Model: Encodable>(_ models: [Model], forKey keyPath: String) {
        let keys = seperate(keyPath: keyPath)
        
        let targetKey = keys.keypath == nil  ? self : addKey(keys.keypath!)
        targetKey.encode(models, keys.valueName)
    }
    
    public func set<Model: Encodable>(_ models: [String : Model], forKey keyPath: String) {
        let keys = seperate(keyPath: keyPath)
        
        let targetKey = keys.keypath == nil  ? self : addKey(keys.keypath!)
        targetKey.encode(models, keys.valueName)
    }
    
    public func set(_ value: Bool, forKey keyPath: String) {
        _set(value, forKey: keyPath)
    }
    
    public func set(_ value: Float, forKey keyPath: String) {
        _set(value, forKey: keyPath)
    }
    
    public func set(_ value: Int, forKey keyPath: String) {
        _set(value, forKey: keyPath)
    }
    
    // Must be plist object
    public func set(_ value: AnyObject?, forKey keyPath: String) {
        _set(value, forKey: keyPath)
    }
    
    public func set(_ value: Double, forKey keyPath: String) {
        _set(value, forKey: keyPath)
    }
    
    func _set<Value>(_ value: Value, forKey keyPath: String) {
        let keys = seperate(keyPath: keyPath)
        let targetKey = keys.keypath == nil  ? self : addKey(keys.keypath!)
        targetKey.encode(value, keys.valueName)
    }
    
    //****************************************************************************//
    // MARK: Getters
    //****************************************************************************//
    
    func _value<Value>(forKey key: String) -> Value? {
        let keys = seperate(keyPath: key)
        let targetKey = keys.keypath == nil ? self : getKey(keys.keypath!)
        
        if let targetKey = targetKey {
            return targetKey.decode(keys.valueName)
        }
        else {
            return nil
        }
    }
    
    public func model<Model: Decodable>(forKey keyPath: String) -> Model? {
        let keys = seperate(keyPath: keyPath)
        let targetKey = keys.keypath == nil ? self : getKey(keys.keypath!)
        
        if let targetKey = targetKey {
            return targetKey.decode(keys.valueName)
        }
        else {
            return nil
        }
    }
    
    public func modelArray<Model: Decodable>(forKey keyPath: String) -> [Model]? {
        let keys = seperate(keyPath: keyPath)
        let targetKey = keys.keypath == nil ? self : getKey(keys.keypath!)
        
        if let targetKey = targetKey {
            return targetKey.decode(keys.valueName)
        }
        else {
            return nil
        }
    }
    
    public func modelDictionary<Model: Decodable>(forKey keyPath: String) -> [String : Model]? {
        let keys = seperate(keyPath: keyPath)
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
    public func bool(forKey key: String) -> Bool? {
        return _value(forKey: key)
    }
    
    /// Returns a Int at key or nil
    public func integer(forKey key: String) -> Int? {
        return _value(forKey: key)
    }
    
    /// Returns a double at key or nil
    public func double(forKey key: String) -> Double? {
        return _value(forKey: key)
    }
    
    /// Returns a Float at key or nil
    public func float(forKey key: String) -> Float? {
        return _value(forKey: key)
    }
    
    /// Returns a String at key or nil
    public func string(forKey key: String) -> String? {
        return _value(forKey: key)
    }
    
    /// Returns the array of strings associated with the key
    public func stringArray(forKey key: String) -> [String]? {
        guard let arData = _value(forKey: key) as? [String] else { return nil }
        return arData
    }
    
    public func array(forKey key: String) -> [AnyObject]? {
        guard let arData = _value(forKey: key) as? [AnyObject] else { return nil }
        return arData
    }
    
    public func dictionary(forKey key: String) -> [String : AnyObject]? {
        guard let dicData = _value(forKey: key) as? [String : AnyObject] else { return nil }
        return dicData
    }
    
    

    //****************************************************************************//
    // MARK: Getters with default values
    //****************************************************************************//
    
    public func bool(forKey key: String , defaultValue: Bool) -> Bool {
        return bool(forKey: key) ?? defaultValue
    }
    
    public func integer(forKey key: String, defaultValue: Int) -> Int {
        return integer(forKey: key) ?? defaultValue
    }
    
    public func double(forKey key: String, defaultValue: Double) -> Double {
        return double(forKey: key) ?? defaultValue
    }
    
    public func float(forKey key: String,  defaultValue: Float) -> Float {
        return float(forKey: key) ?? defaultValue
    }
    
    public func string(forKey key: String, defaultValue: String) -> String {
        return string(forKey: key) ?? defaultValue
    }
    
    public func stringArray(forKey key: String, defaultValue: [String]) -> [String] {
        return stringArray(forKey: key) ?? defaultValue
    }
    
    public func array(forKey key: String, defaultValue: [AnyObject]) -> [AnyObject] {
        return array(forKey: key) ?? defaultValue
    }
    
    public func dictionary(forKey key: String, defaultValue: [String : AnyObject]) -> [String : AnyObject] {
        return dictionary(forKey: key) ?? defaultValue
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
        let keys = seperate(keyPath: key)
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
        let keys = seperate(keyPath: key)
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
    
    func walk(descendAction: @noescape(KVStore) throws -> KVStore?,
                        ascendAction: @noescape(KVStore, KVStore)  throws -> Void) rethrows -> Void {
        
        guard let child = try descendAction(self) else {
            return
        }
        try child.walk(descendAction: descendAction, ascendAction: ascendAction)
        try ascendAction(self, child)
    }
    
    func edit<V>(path keys: [String], editor: (KVStore) throws -> V,
              onMissingKey: (KVStore, String) throws -> KVStore? ) throws -> V  {
        var keyGen = keys.makeIterator()
        var result : V? = nil
        
        try walk(
            descendAction:  { store in
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
            ascendAction: { _, _ in  }
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
func split(keyPath: String) -> [String] {
    return keyPath.characters.split(separator: ".").map(String.init)
}

/// Join keys with `KeypathSeperator`
func join(keys: [String]) -> String {
    return keys.joined(separator: String(KeypathSeperator))
}

public func seperate(keyPath: String) -> (keypath: String?, valueName: String) {
    var keys = split(keyPath: keyPath)
    let key = keys.removeLast()
    let joinResult = join(keys: keys)
    let keypath : String? = joinResult.characters.count > 0 ? joinResult : nil
    return (keypath, key)
}
