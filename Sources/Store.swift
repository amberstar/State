let KeypathSeperator : Character = "."
let StoreKey = "KEYS"
let DataKey = "VALUES"
let RefKey = "REFERENCE"
let VolatileKey = "VOLATILE"
let HeaderKey = "HEADER"


public enum KVStoreError : ErrorType {
   case KeyNotFound(String)
   case NoResult
}

/// A KVStore is a general purpose key-value store for models and/or arbitrary
/// values. It is useful in situations where it makes sense to store a group of
/// models or collections of models together, but there is not a need to create
/// a collection model type. Instead conveniently store them in a Store. A
/// - Store can have child stores.
/// - When you ask for something from a store, you do so with a `keypath`

public final class KVStore: Encodable, Decodable {
   
   class KVContainer : EncoderType, DecoderType {
      var data = [String : AnyObject]()
      var keys : [String : KVStore] = [:]
      
      var nonVolatileKeys : [String : KVStore] {
         return filterKeys(keys, shouldKeep: { $0.isVolatile == false })
      }
      
      var localKeys : [String : KVStore] {
         return filterKeys(keys, shouldKeep: { $0.externalLocation == nil } )
      }
      
      var localNonVolatileKeys : [String : KVStore] {
          return filterKeys(nonVolatileKeys, shouldKeep: { $0.externalLocation == nil } )
      }
      
      var externalKeys : [String : KVStore] {
          return filterKeys(keys, shouldKeep: { $0.externalLocation != nil } )
      }
      
      func filterKeys(keys: [String : KVStore], shouldKeep: (KVStore) -> Bool) -> [String : KVStore] {
         var data : [String : KVStore] = [:]
         let filteredKeys = keys.filter { shouldKeep($1) }
         for result in   filteredKeys {
            data[result.0] = result.1
         }
         return data
      }
      
      init(data: [String : AnyObject] =  [:], keys: [String : KVStore] = [:]) {
         self.data = data
         self.keys = keys
      }
   }
   
   let container : KVContainer
   
   public var isVolatile : Bool {
      get {
         return getBool(HeaderKey + "." + VolatileKey, defaultValue: false)
      }
      set {
         setValue(newValue, forKey: HeaderKey + "." + VolatileKey)
      }
   }
   
   public var externalLocation : String? {
      get {
         return getString(HeaderKey + "." + RefKey)
      }
      set {
         setValue(newValue, forKey: HeaderKey + "." + RefKey)
      }
   }
   
   public var keys : [String : KVStore] {
      return container.keys
   }
   
   public var values : [String : AnyObject] {
      return container.data
   }
   
   /// Initialize a new Store with the specified value and key dictionaries
   public init(path: String? = nil, values: [String : AnyObject] =  [:], keys: [String : KVStore] = [:]) {
      container = KVContainer(data: values, keys: keys)
   }
   
   
   public func save(path: String) {
      save(.Plist, path: path)
      saveExternalKeys()
   }
   
   func saveExternalKeys() {
      for key in container.externalKeys {
         if let location = key.1.externalLocation {
            key.1.save(location)
         }
      }
      for key in container.localNonVolatileKeys {
         key.1.saveExternalKeys()
      }
   }
   
   
   public static func load(path: String) -> KVStore? {
      return KVStore.decodeFromFile(Format.Plist.converter, path: path)
   }
   
   //****************************************************************************//
   // MARK: Coding
   //****************************************************************************//
   
   public func encode(encoder: Encoder) {
      
      if container.data.count > 0 {
         encoder.encode(container.data, DataKey)
      }
   
      if container.localNonVolatileKeys.count > 0 {
         encoder.encode(container.localNonVolatileKeys, StoreKey)
      }
      
      for key in container.externalKeys {
         let reference : [String : String ] = [RefKey : key.1.externalLocation!]
         encoder.encode(reference, key.0)
      }
   }
   
   public static func decode(decoder: Decoder) -> Self? {
      let stores : [String : KVStore]? = decoder.decode(StoreKey)
      let data : [String : AnyObject]? = decoder.decode(DataKey)

      return self.init(values: data ?? [:], keys: stores ?? [:])
      
   }
   //****************************************************************************//
   // MARK: Stores - Creating, Getting, Updating
   //****************************************************************************//
   
   /// Return the key at the keypath
   /// or nil if not found
   public func getKey(keypath: String)  ->  KVStore? {
      let editor: KVStore -> KVStore = { store in
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
   public func createKey(keypath: String) -> KVStore {
      var keyNames: [String] = splitKeypath(keypath)
      let keyName: String = keyNames.removeLast()
      
      func addNewKeyToKey(key: KVStore, name: String) -> KVStore {
         let newStore = KVStore()
         key.container.keys[name] = newStore
         return newStore
      }
      
      // if key already exsists return it
      if let key = getKey(keypath) {
         return key
      }
      else {
         let editor: KVStore throws -> KVStore = { key in
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
   public func updateKey(keypath: String, newKey key: KVStore) -> KVStore? {
      var keyNames = splitKeypath(keypath)
      let targetKeyName = keyNames.removeLast()
      let parent = createKey(joinKeypath(keyNames))
      return parent.container.keys.updateValue(key, forKey: targetKeyName)
   }
   
   /// Removes the key at `keypath` and returns it or
   /// returns nil if not found.
   public func removeKey(keypath: String) -> KVStore? {
      var keyNames = splitKeypath(keypath)
      let keyName = keyNames.removeLast()
      let editor : KVStore -> KVStore? = { key in
         return key.container.keys.removeValueForKey(keyName)
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
      public func merge(source: KVStore, intoKeypath: String  ) -> KVStore {
         let targetKey = createKey(intoKeypath)
         return targetKey.merge(source)
      }
   
      /// Deep merges the sourceKey into the reciever
      public func merge(source: KVStore) -> KVStore {
         self.container.data.merge(source.container.data)
         
         for entry in source.container.keys {
            // if we already have this key, merge them
            if let targetKey = container.keys[entry.0] {
               targetKey.merge(entry.1)
            }
            // else add the key
            else {
               self.container.keys[entry.0] = entry.1
            }
         }
         return self
      }

   //****************************************************************************//
   // MARK: Setters
   //****************************************************************************//
   
   public func setValue<V: Encodable>(value: V, forKey: String) {
      let keys = seperateKeypath(forKey)
      
      let targetKey = keys.keypath == nil  ? self : createKey(keys.keypath!)
      targetKey.container.encode(value, keys.valueName)
   }
   
   public func setValue<T: Encodable>(value: [T], forKey: String) {
      let keys = seperateKeypath(forKey)
      
      let targetKey = keys.keypath == nil  ? self : createKey(keys.keypath!)
      targetKey.container.encode(value, keys.valueName)
   }
   
   public func setValue<T: Encodable>(value: [String : T], forKey: String) {
      let keys = seperateKeypath(forKey)
      
      let targetKey = keys.keypath == nil  ? self : createKey(keys.keypath!)
      targetKey.container.encode(value, keys.valueName)
   }
   
   public func setValue<V>(value: V, forKey: String) {
      let keys = seperateKeypath(forKey)
      
      let targetKey = keys.keypath == nil  ? self : createKey(keys.keypath!)
      targetKey.container.encode(value, keys.valueName)
   }
   
   //****************************************************************************//
   // MARK: Getters
   //****************************************************************************//
   
   public func getValue<T>(key: String) -> T? {
      let keys = seperateKeypath(key)
      let targetKey = keys.keypath == nil ? self : getKey(keys.keypath!)
      
      if let targetKey = targetKey {
         return targetKey.container.decode(keys.valueName)
      }
      else {
         return nil
      }
   }
   
   public func getValue<T: Decodable>(key: String) -> T? {
      let keys = seperateKeypath(key)
      let targetKey = keys.keypath == nil ? self : getKey(keys.keypath!)
      
      if let targetKey = targetKey {
         return targetKey.container.decode(keys.valueName)
      }
      else {
         return nil
      }
   }
   
   public func getValue<T: Decodable>(key: String) -> [T]? {
      let keys = seperateKeypath(key)
      let targetKey = keys.keypath == nil ? self : getKey(keys.keypath!)
      
      if let targetKey = targetKey {
         return targetKey.container.decode(keys.valueName)
      }
      else {
         return nil
      }
   }
   
   public func getValue<T: Decodable>(key: String) -> [String : T]? {
      let keys = seperateKeypath(key)
      let targetKey = keys.keypath == nil ? self : getKey(keys.keypath!)
      
      if let targetKey = targetKey {
         return targetKey.container.decode(keys.valueName)
      }
      else {
         return nil
      }
   }
   
   //****************************************************************************//
   // MARK: Basic Getters
   //****************************************************************************//
   
   /// Returns a Bool at key or nil
   public func getBool(key: String) -> Bool? {
      return getValue(key)
   }
   
   /// Returns a Int at key or nil
   public func getInt(key: String) -> Int? {
      return getValue(key)
   }
   
   /// Returns a double at key or nil
   public func getDouble(key: String) -> Double? {
      return getValue(key)
   }
   
   /// Returns a Float at key or nil
   public func getFloat(key: String) -> Float? {
      return getValue(key)
   }
   
   /// Returns a String at key or nil
   public func getString(key: String) -> String? {
      return getValue(key)
   }
   
   //****************************************************************************//
   // MARK: Getters with default values
   //****************************************************************************//
   
   public func getBool(key: String , defaultValue: Bool) -> Bool {
      return getValue(key) ?? defaultValue
   }
   
   public func getInt(key: String, defaultValue: Int) -> Int {
      return getValue(key) ?? defaultValue
   }
   
   public func getDouble(key: String, defaultValue: Double) -> Double {
      return getValue(key) ?? defaultValue
   }
   
   public func getFloat(key: String,  defaultValue: Float) -> Float {
      return getValue(key) ?? defaultValue
   }
   
   public func getString(key: String, defaultValue: String) -> String {
      return getValue(key) ?? defaultValue
   }
   
   public func getValue<T>(key: String, defaultValue: T) -> T {
      return getValue(key) ?? defaultValue
   }
   
   public func getValue<T: Decodable>(key: String, defaultValue: T) -> T {
      return getValue(key) ?? defaultValue
   }
   
   public func getValue<T: Decodable>(key: String, defaultValue: [T]) -> [T] {
       return getValue(key) ?? defaultValue
   }
   
   public func getValue<T: Decodable>(key: String,  defaultValue: [String : T]
     ) -> [String : T] {
      return getValue(key) ?? defaultValue
   }
   
//****************************************************************************//
// MARK: Removal
//****************************************************************************//
   
   /// Removes a value at key and returns it,
   /// or returns nil if not found
   public func removeValue<T>(key: String) -> T? {
      return removeValue(key) { store, valueName in
         return store.container.decode(valueName)
      }
   }
   
   /// Removes a value at key and returns it,
   /// or returns nil if not found
   public func removeValue<T: Decodable>(key: String) -> T? {
      return removeValue(key) { store, valueName in
         return store.container.decode(valueName)
      }
   }
   
   /// Removes a value at key and returns it,
   /// or returns nil if not found
   public func removeValue<T: Decodable>(key: String) -> [T]? {
      return removeValue(key) { store, valueName in
         return store.container.decode(valueName)
      }
   }
   
   /// Removes a value at key and returns it,
   /// or returns nil if not found
   public func removeValue<T: Decodable>(key: String) -> [String : T]? {
      return removeValue(key) { store, valueName in
         return store.container.decode(valueName)
      }
   }
   
   /// Removes a value at key and returns it,
   /// or returns nil if not found
   func removeValue<T>(key: String, decode: (KVStore, String) ->  T? ) -> T? {
      let keys = seperateKeypath(key)
      let targetKey = keys.keypath == nil ? self : getKey(keys.keypath!)
      
      if let targetKey = targetKey {
         let value : T? =  decode(targetKey, keys.valueName)
         targetKey.container.data.removeValueForKey(keys.valueName)
         return value
      }
      else {
         return nil
      }
   }
   
   /// Simillar to remove but does not return
   /// the value removed.
   public func deleteValue(key: String) {
      let keys = seperateKeypath(key)
      let targetKey = keys.keypath == nil ? self : getKey(keys.keypath!)
      
      if let targetKey = targetKey {
         targetKey.container.data.removeValueForKey(keys.valueName)
      }
   }
}

//****************************************************************************//
// MARK: Implementations
//****************************************************************************//

extension KVStore {
   
   func walk(@noescape descend descend: KVStore throws -> KVStore?,
                               @noescape ascend: (KVStore, KVStore)  throws -> Void) rethrows -> Void {
      
      guard let child = try descend(self) else {
         return
      }
      try child.walk(descend: descend, ascend: ascend)
      try ascend(self, child)
   }
   
   func edit<V>(keys: [String], editor: KVStore throws -> V,
      onMissingKey: (KVStore, String) throws -> KVStore? ) throws -> V  {
      var keyGen = keys.generate()
      var result : V? = nil
      
      try walk(
         descend:  { store in
            guard let nextKey = keyGen.next() else {
               // bottom
               result = try editor(store)
               return nil
            }
            guard let next = store.container.keys[nextKey] else {
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
         throw KVStoreError.NoResult
      }
   }
}

extension Dictionary {
   /// Merges the dictionary with dictionaries passed. The latter dictionaries will override
   /// values of the keys that are already set
   ///
   /// :param dictionaries A comma seperated list of dictionaries
   mutating func merge<K, V>(dictionaries: Dictionary<K, V>...) {
      for dict in dictionaries {
         for (key, value) in dict {
            self.updateValue(value as! Value, forKey: key as! Key)
         }
      }
   }
}

///  Split keys into an array of strings
func splitKeypath(path: String) -> [String] {
   return path.characters.split(".").map(String.init)
}

/// Join keys with `KeypathSeperator`
func joinKeypath(keys: [String]) -> String {
   return keys.joinWithSeparator(String(KeypathSeperator))
}

func seperateKeypath(path: String) -> (keypath: String?, valueName: String) {
   var keys = splitKeypath(path)
   let key = keys.removeLast()
   let joinResult = joinKeypath(keys)
   let keypath : String? = joinResult.characters.count > 0 ? joinResult : nil
   return (keypath, key)
}

