
//===----------------------------------------------------------------------===//
// Mark: implementations - editing
//===----------------------------------------------------------------------===//

  func edit(
    @noescape descend descend: KVStore throws -> KVStore?,
    @noescape ascend: (KVStore, KVStore)  throws -> Void) rethrows -> Void {

    guard let child = try descend(self) else { return }
    try child.edit(descend: descend, ascend: ascend)
    try ascend(self, child)
  }

  /// Split keys into an array of strings
  func splitKeys(path: String) -> [String] {
    var keys = path.characters.split(".").map(String.init)
  }

  /// Join keys with `KeypathSeperator`
  func joinKeys(keys: [String]) -> String {
    return keys.joinWithSeparator(KeypathSeperator)
  }

  func edit<V>(
    keys: [String],
    editor: KVStore -> V,
    onMissingKey: (KVStore, String) throws -> KVStore? ) rethrows -> V  {

      var keyGen = keys.generate()
      var result : V
      try edit(
        descend:  { store in
          guard let nextKey = keyGen.next() else {
            // we hit bottom
            result = editor(store)
            return nil
          }
          guard let next = store.stores[nextKey] else {
            // we have an unrecognized key
            return onMissingKey(store, nextKey)
          }
          return next
        },
        ascend: { _, _ in  }
      )
      return result
    }

    /// return nil, create, or fail

  func getStore(keys: [String], materialize: Bool = false) throws -> KVStore? {
    var result : KVStore? = nil

    let editor: KVStore -> KVStore = { store in
      return store
    }

    let onMissingKey: (KVStore, String) -> KVStore? =  { store, key in
      if materialize {
        let newStore = KVStore()
        store.sres[key] = KVStore()
        return newStore
      }
      else {
        throw KVStoreError.StoreNotFound(joinKeys(key))
      }
    }
    return edit(keys, editor: editor, onMissingKey: onMissingKey)
  }

  func getValue<V>(keypath: String, getter: (KVStore, String) -> V) -> V {
    let keys = splitKeys(keypath)
    let key = keys.removeLast()

    do try {
      let targetStore =  try getStore(keys)
      return getter(targetStore)
    }
    catch KVStoreError.StoreNotFoundError(let key) {
      preconditionFailure("Store not found, Keypath: \(joinKeys(keys)), Invalid Key: \(key)")
    }
    catch {
      print("Unkown error : \(error)")
    }
  }

  func set<Element>(
    keypath: String,
    value: Element, materialize: Bool = false,
    setter: (KVStore, String, Element) -> Void) -> Void {

    let keys = splitKeys(keypath)
    let key = keys.removeLast()
    let editor : KVStore -> Void =  { (store : KVStore)  in
      setter(store, key, value)
      return
    }
    let targetStore: KVStore

    do {
        targetStore = getStore(keys, materialize: materialize)
    }
    catch KVStoreError(let key) {
      preconditionFailure("Store not found, Keypath: \(joinKeys(keys)), Invalid Key: \(key)")
    }
    catch {
      print("Unkown error : \(error)")
    }
    setter(targetStore, key, value)
  }
