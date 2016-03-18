
let KVStoreVersion = "1.0"
let KVStoreVersionKey  = "KVStore.Version"
let KeypathSeperator : Character = "."

public enum KVStoreError : ErrorType {
  case SaveError(KVStore)
  case StoreNotFound(String)
}

public struct KVStoreOptions: OptionSetType {
  public let rawValue: Int

  public init(rawValue: Int) {
    self.rawValue = rawValue
  }

  static let Add = KVStoreOptions(rawValue: 1)
  static let Update = KVStoreOptions(rawValue: 2)
}

func bg_save(container container: KVStore, path: String) {
  makeAsyncRequest({
    let result : Bool = container.save(.Plist, path: path)
    if !result { throw KVStoreError.SaveError(container) }
    return result

  }, complete: { (result : () throws -> Bool ) in

    do {
      try result()
    }
    catch {
      print(error)
    }
  })
}

// domain/container/value


/// A KVStore is a general purpose key-value store for models and arbitrary
/// values. It is useful in situations where it makes sense to store a group of
/// models or collections of models together, but there is not a need to create
/// a collection model type. Instead conveniently store them in a KVStore. A
/// KVStore can have child stores.
public class KVStore: KVEncoder, KVDecoder {

  /// The store containers contained in the domain
  public var stores : [String : KVStore] = [:]

  var path: String?

  /// The raw key value data of the container
  public var data = [String : AnyObject]() {
    didSet {
      if let path = self.path {
        // TODO: update this
        bg_save(container: self, path: path)
      }
    }
  }

  /// Initialize a new KVStore with data
  public init(data: [String : AnyObject] =  [:]) {
    self.data = data
    //setValue(KVStoreVersionKey, forKey: KVStoreVersion)
  }

  /// Initialize a new KVStore from a file
  public init?(_ format: Format, path: String) {

    if let d =  format.converter.read(path) {
      self.data = d
    } else { return nil }
  }

  /// Save store to a file
  public func save(format: Format, path: String) -> Bool {
    return format.converter.write(self.data, path: path)
  }

//****************************************************************************//
  // Mark: Store
//****************************************************************************//

  /// Return a store at the keypath or nil if not found.
  ///
  /// - parameter materialize: if `true` any intermediate stores are created
  /// - seeAlso: `materializeStore(atKeypath:)`
  public func getStore(keypath keypath: String, materialize: Bool = false) -> KVStore? {
    let keys = splitKeys(keypath)
    return getStore(keys, materialize: materialize)
  }

  /// Retrieves a store at `keypath`, or creates it if it does not exsist
  ///
  /// - note: this will create any neccessary intermediate stores required.
  /// - seeAlso: `getStore(atKeypath:, materialize:)`
  public func materializeStore(keypath keypath: String) -> KVStore {
    return getStore(keypath: keypath, materialize: true )
  }

  /// Sets the `store` at `keypath` to `store`
  ///
  /// - note: This will either add or update the store
  /// - requires: `keypath` is valid
  /// - parameter materialize: if `true` any intermediate stores will be created
  public func setStore (
    store: KVStore = KVStore(),
    keypath: String,
    materialize: Bool = false) -> KVStore {

      let setter: (KVStore, String, KVStore) -> Void = { (parentStore, key, childStore) in
        parentStore.stores[key] = childStore
      }
      setValue(keypath: keypath, value: store, materialize: materialize)
  }

  /// Removes the store at `keypath` and returns it or
  /// nil if not found.
  public func removeStore(keypath: String) -> KVStore? {
    let keys = splitKeys(keypath)
    let key = keys.removeLast()
    let editor : KVStore -> KVStore? = { store in
      return store.removeValueForKey(key)
    }
    let onMissingKey : onMissingKey: (KVStore, String) throws -> KVStore? ) = { store, key in {
        print("Store not found, Invalid Key: \(keypath) Key: \(key)"
        return nil
    }
    let result : KVStore? =  try! edit(keys: keys, editor: editor, onMissingKey: onMissingKey)
    return result
  }

//****************************************************************************//
// Mark: Model setters
//****************************************************************************//

  public func setModel<T: Model>(keypath: String, model: T) {
    set(keypath, value: model, materialize: false) { store,  key,  model in
      store.encode(model, key)
    }
  }

  public func setModels>T: Model>(keypath: String, models: [T]) {
    set(keypath, value: model, materialize: false) { store,  key,  model in
      store.encode(models, key)
    }
  }

  public func setModels<T: Model>(keypath: String, models: [String : T]) {
    set(keypath, value: model, materialize: false) { store,  key,  model in
      store.encode(models, key)
    }
  }

  public func setValue<T>(value: T, forKey key: String) {
    self.encode(value, key)
  }

//****************************************************************************//
// Mark: Getters
//****************************************************************************//

public func getModel<T: Model>(keypath: String) -> T? {
  return get(keypath) { store, key in
    return store.decodeModel(key)
  }
}

public func getModels<T: Model>(keypath: String) -> [T]? {
  return get(keypath) { store, key in
    return store.decodeModelArray(key)
  }
}

public func getModels<T: Model>(keypath: String) -> [String : T]? {
  return get(keypath) { store, key in
    return store.decodeModelDictionary(key)
  }
}

/// Merge a containers data into the receiver
/// adding or updating any values
public func merge(store: KVStore) {
  self.data.merge(store.data)
}

// Mark: basic type accessors
extension KVStore {
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
    let components = keypath.characters.split(KeypathSeperator).map(String.init)
    return _getValue(components)
  }

  private func _getValue<T>(keys: [String]) -> T? {
    var keys = keys
    guard let key = keys.first else { return nil }
    guard keys.count > 1 else { return _getValue(key) }
    return stores[keys.removeFirst()]?._getValue(keys)
  }

  /// Returns a value at key or nil
  private func _getValue<T>(key: String) -> T? {
    return self.decode(key)
  }
}

// Mark: Basic setters


// Mark: default value accessors

extension KVStore {

  public func getBool(keypath: String, defaultValue: Bool, options: KVStoreOptions = []) -> Bool {
    return _getValue(keypath, defaultValue: defaultValue, options: options)
  }

  public func getInt(keypath: String, defaultValue: Int, options: KVStoreOptions = []) -> Int {
    return _getValue(keypath, defaultValue: defaultValue, options: options)
  }

  public func getDouble(keypath: String, defaultValue: Double, options: KVStoreOptions = []) -> Double {
    return _getValue(keypath, defaultValue: defaultValue, options: options)
  }

  public func getFloat(keypath: String, defaultValue: Float, options: KVStoreOptions = []) -> Float {
    return _getValue(keypath, defaultValue: defaultValue, options: options)
  }

  /// Returns a String at key or nil
  public func getString(keypath: String, defaultValue: String, options: KVStoreOptions = []) -> String {
    return _getValue(keypath, defaultValue: defaultValue, options: options)
  }

  public func getModel<T: Model>(keypath: String, defaultValue: T, options: KVStoreOptions = []) -> T {
    return _materializeValue(keypath, value: getModel(keypath), defaultValue: defaultValue, options: options, addValue: setValue)
  }

  public func getModels<T: Model>(keypath: String, defaultValue: [T], options: KVStoreOptions = []) -> [T] {
    return _materializeValue(keypath, value: getModels(keypath), defaultValue: defaultValue, options: options, addValue: setValue)
  }

  public func getModels<T: Model>(keypath: String, defaultValue: [String : T], options: KVStoreOptions = []) -> [String : T] {
    return _materializeValue(keypath, value: getModels(keypath), defaultValue: defaultValue, options: options, addValue: setValue)
  }

  private func _getValue<T>(keypath: String, defaultValue: T, options: KVStoreOptions = []) -> T {
    return _materializeValue(keypath, value: _getValue(keypath: keypath), defaultValue: defaultValue, options: options, addValue: setValue)
  }

  private func _materializeValue<T>(keypath: String, value: T?, defaultValue: T, options: KVStoreOptions, @noescape addValue: (T, forKey: String) -> ()) -> T {
    if let value = value { return value }

    if options.contains(.Add) {
      addValue(defaultValue, forKey: keypath)
    }
    return defaultValue
  }
}


// MARK: bg_save

import Foundation

let bg_queue = dispatch_get_global_queue(QOS_CLASS_BACKGROUND,0)
//let bg_queue = dispatch_get_main_queue()
let call_back_queue = dispatch_get_main_queue()

private func makeAsyncRequest<Value>(request: () throws -> Value, complete: (() throws -> Value)  -> ()) {

  dispatch_async(bg_queue) {
    let result : Value

    do {
      try result = request()
      complete { return result }
    }
    catch {
      dispatch_async(call_back_queue) {
        complete() {
          throw error
        }
      }
    }
  }
}
