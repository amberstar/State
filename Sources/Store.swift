let KeypathSeperator : Character = "."
let StoreKey = "Keys"
let DataKey = "Values"

public enum StoreError : ErrorType {
   case StoreNotFound(String)
}

/// A Store is a general purpose key-value store for models and arbitrary
/// values. It is useful in situations where it makes sense to store a group of
/// models or collections of models together, but there is not a need to create
/// a collection model type. Instead conveniently store them in a Store. A
/// Store can have child stores.
public final class Store: EncoderType, DecoderType, Encodable, Decodable {
   
   /// The child stores contained in the store
   public var stores : [String : Store] = [:]
   
   var path: String?
   
   /// The raw key value data of the container
   public var data = [String : AnyObject]()
   
   /// Initialize a new Store with data
   public init(data: [String : AnyObject] =  [:], stores: [String : Store] = [:]) {
      self.data = data
      self.stores = stores
   }
   
   public func save(path: String) {
      self.save(.Plist, path: path)
   }
   
   public static func load(path: String) -> Store? {
      return Store.decodeFromFile(Format.Plist.converter, path: path)
   }
   
   //****************************************************************************//
   // MARK: Coding
   //****************************************************************************//
   
   public func encode(encoder: Encoder) {
      
      if data.count > 0 {
         encoder.encode(data, DataKey)
      }
      
      if stores.count > 0 {
         encoder.encode(stores, StoreKey)
      }
   }
   
   public static func decode(decoder: Decoder) -> Self? {
      let stores : [String : Store]? = decoder.decode(StoreKey)
      let data : [String : AnyObject]? = decoder.decode(DataKey)

      return self.init(data: data ?? [:], stores: stores ?? [:])
      
   }
   //****************************************************************************//
   // MARK: Store
   //****************************************************************************//
   
   /// Return a store at the keypath or nil if not found.
   ///
   /// - parameter materialize: if `true` any intermediate stores are created
   /// - seeAlso: `materializeStore(atKeypath:)`
   public func getStore(keypath: String, add: Bool = false) -> Store? {
      let keys = Store.splitKeys(keypath)
      do {
         return try getStore(keys, add: add)
      }
      catch {
         print(error)
         return nil
      }
   }
   
   /// Removes the store at `keypath` and returns it or
   /// nil if not found.
   public func removeStore(keypath: String) -> Store? {
      var keys = Store.splitKeys(keypath)
      let key = keys.removeLast()
      let editor : Store -> Store? = { store in
         return store.stores.removeValueForKey(key)
      }
      let onMissingKey : (Store, String) throws -> Store? = { store, key in
         print("Store not found, Invalid Key: \(keypath) Key: \(key)")
         return nil
      }
      let result : Store? =  try! edit(keys, editor: editor, onMissingKey: onMissingKey)
      return result
   }
   
   public func addStore(keypath: String, store: Store = Store()) -> Store {
      return setStore(store, keypath: keypath, add: true)
   }
   
   public func updateStore(keypath: String, store: Store) -> Store {
      return setStore(store, keypath: keypath, add: false)
   }
   
   public func mergeStore(keypath: String, store: Store ) -> Store? {
      
      if let targetStore = getStore(keypath) {
         targetStore.data.merge(store.data)
         targetStore.stores.merge(store.stores)
         return targetStore
      }
      else { return nil }
   }
   
   public func mergeStore(store: Store) -> Store? {
      self.data.merge(store.data)
      self.stores.merge(store.stores)
      return self
   }
   
   //****************************************************************************//
   // MARK: Setters
   //****************************************************************************//
   
   public func set<T: Encodable>(keypath: String, _ model: T, add: Bool = true) {
      set(keypath, value: model, add: add) { store,  key,  model in
         store.encode(model, key)
      }
   }
   
   public func set<T: Encodable>(keypath: String, _ models: [T], add: Bool = true) {
      set(keypath, value: models, add: add) { store,  key,  model in
         store.encode(models, key)
      }
   }
   
   public func set<T: Encodable>(keypath: String, _ models: [String : T], add: Bool = true) {
      set(keypath, value: models, add: add) { store,  key,  model in
         store.encode(models, key)
      }
   }
   
   public func set<V>(keypath: String, _ value: V, add: Bool = true) {
      set(keypath, value: value, add: add) { store,  key,  value in
         store.encode(value, key)
      }
   }
   
   //****************************************************************************//
   // MARK: Model Getters
   //****************************************************************************//
   
   public func getModel<T: Decodable>(keypath: String) -> T? {
      return getValue(keypath) { store, key in
         return store.decode(key)
      }
   }
   
   public func getModels<T: Decodable>(keypath: String) -> [T]? {
      return getValue(keypath) { store, key in
         return store.decode(key)
      }
   }
   
   public func getModels<T: Decodable>(keypath: String) -> [String : T]? {
      return getValue(keypath) { store, key in
         return store.decode(key)
      }
   }
   
   //****************************************************************************//
   // MARK: Basic Getters
   //****************************************************************************//
   
   /// Returns a Bool at key or nil
   public func getBool(keypath: String) -> Bool? {
      return _getValue(keypath: keypath)
   }
   
   /// Returns a Int at key or nil
   public func getInt(keypath: String) -> Int? {
      return _getValue(keypath: keypath)
   }
   
   /// Returns a double at key or nil
   public func getDouble(keypath: String) -> Double? {
      return _getValue(keypath: keypath)
   }
   
   /// Returns a Float at key or nil
   public func getFloat(keypath: String) -> Float? {
      return _getValue(keypath: keypath)
   }
   
   /// Returns a String at key or nil
   public func getString(keypath: String) -> String? {
      return _getValue(keypath: keypath)
   }
   private func _getValue<T>(keypath keypath: String) -> T? {
      
      return getValue(keypath) { store, key in
         return store.decode(key)
      }
   }
   
   //****************************************************************************//
   // MARK: Getters with default values
   //****************************************************************************//
   
   public func getBool(keypath: String, defaultValue: Bool, add: Bool = true) -> Bool {
      return _getValue(keypath, defaultValue: defaultValue, add: add)
   }
   
   public func getInt(keypath: String, defaultValue: Int, add: Bool = true) -> Int {
      return _getValue(keypath, defaultValue: defaultValue, add: add)
   }
   
   public func getDouble(keypath: String, defaultValue: Double, add: Bool = true) -> Double {
      return _getValue(keypath, defaultValue: defaultValue, add: add)
   }
   
   public func getFloat(keypath: String, defaultValue: Float, add: Bool = true) -> Float {
      return _getValue(keypath, defaultValue: defaultValue, add: add)
   }
   
   public func getString(keypath: String, defaultValue: String, add: Bool = true) -> String {
      return _getValue(keypath, defaultValue: defaultValue, add: add)
   }
   
   public func getModel<T: Decodable>(keypath: String, defaultValue: T, add: Bool = true) -> T {
      return materializeValue(keypath, value: getModel(keypath), defaultValue: defaultValue, add: add)
   }
   
   public func getModels<T: Decodable>(keypath: String, defaultValue: [T], add: Bool = true) -> [T] {
      return materializeValue(keypath, value: getModels(keypath), defaultValue: defaultValue, add: add)
   }
   
   public func getModels<T: Decodable>(keypath: String, defaultValue: [String : T], add: Bool = true) -> [String : T] {
      return materializeValue(keypath, value: getModels(keypath), defaultValue: defaultValue, add: add)
   }
   
   private func _getValue<T>(keypath: String, defaultValue: T, add: Bool = true) -> T {
      return materializeValue(keypath, value: _getValue(keypath: keypath), defaultValue: defaultValue, add: add)
   }
   
   public func materializeValue<T>(keypath: String, value: T?, defaultValue: T, add: Bool = true) -> T {
      if let value = value { return value }
      
      if add {
         set(keypath, value: defaultValue, add: true) { store,  key,  value in
            store.encode(value, key)
         }
      }
      return defaultValue
   }
}


//****************************************************************************//
// MARK: Implementations
//****************************************************************************//

extension Store {
   
   func edit(
      @noescape descend descend: Store throws -> Store?,
                        @noescape ascend: (Store, Store)  throws -> Void) rethrows -> Void {
      
      guard let child = try descend(self) else { return }
      try child.edit(descend: descend, ascend: ascend)
      try ascend(self, child)
   }
   
   ///  Split keys into an array of strings
   static func splitKeys(path: String) -> [String] {
      return path.characters.split(".").map(String.init)
   }
   
   /// Join keys with `KeypathSeperator`
   static func joinKeys(keys: [String]) -> String {
      return keys.joinWithSeparator(String(KeypathSeperator))
   }
   
   func edit<V>(
      keys: [String],
      editor: Store -> V,
      onMissingKey: (Store, String) throws -> Store? ) rethrows -> V  {
      var keyGen = keys.generate()
      var result : V? = nil
      
      try edit(
         descend:  { store in
            guard let nextKey = keyGen.next() else {
               // we hit bottom
               result = editor(store)
               return nil
            }
            guard let next = store.stores[nextKey] else {
               // we have an unrecognized key
               return  try onMissingKey(store, nextKey)
            }
            return next
         },
         ascend: { _, _ in  }
      )
      return result!
   }
   
   func getStore(keys: [String], add: Bool = false) throws -> Store? {
      let editor: Store -> Store = { store in
         return store
      }
      let onMissingKey: (Store, String) throws -> Store? =  { store, key in
         if add {
            let newStore = Store()
            store.stores[key] = newStore
            return newStore
         }
         else {
            throw StoreError.StoreNotFound(Store.joinKeys(keys))
         }
      }
      return try edit(keys, editor: editor, onMissingKey: onMissingKey)
   }
   
   func setStore (
      store: Store = Store(),
      keypath: String,
      add: Bool = false) -> Store {
      
      let setter: (Store, String, Store) -> Void = { (parentStore, key, childStore) in
         parentStore.stores[key] = childStore
      }
      set(keypath, value: store, add: add, setter: setter)
      return store
   }
   
   
   func getValue<V>(keypath: String, getter: (Store, String) -> V) -> V {
      var keys = Store.splitKeys(keypath)
      let key = keys.removeLast()
      var targetStore : Store? = nil
      
      do {
         targetStore =  try getStore(keys, add: true)
      }
      catch StoreError.StoreNotFound(let key) {
         preconditionFailure("Store not found, Keypath: \(Store.joinKeys(keys)), Invalid Key: \(key)")
      }
      catch {
         print("Unkown error : \(error)")
      }
      
      return getter(targetStore!, key)
   }
   
   func set<Element>(
      keypath: String,
      value: Element, add: Bool = false,
      setter: (Store, String, Element) -> Void) -> Void {

      var keys = Store.splitKeys(keypath)
      let key = keys.removeLast()
      let targetStore: Store?
      
      do {
         targetStore = try getStore(keys, add: add)
         setter(targetStore!, key, value)
      }
      catch StoreError.StoreNotFound(let key) {
         preconditionFailure("Store not found, Keypath: \(Store.joinKeys(keys)), Invalid Key: \(key)")
      }
      catch {
         print("Unkown error : \(error)")
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