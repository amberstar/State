
let KVStoreVersion = "1.0"
let KVStoreVersionKey  = "KVStore.Version"

public enum KVStoreError : ErrorType {
    case SaveError(KVStoreContainer)
}

func bg_save(container container: KVStoreContainer, path: String) {
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


/// A KVStore is a general purpose key-value store for models and arbritray values.
/// A KVStore has domains which then have containers. You can think of these
/// as categories and sub-categories. A container represents one unit of KV storage
/// usually stored on disk in a plist file, or JSON.
///
/// This is not intended as the primary way to save models, as those can be stored
/// in their own files. Rather this is designed as a central store applications can use
/// when it needs to share values across a domain, such as configuration, defaults,
/// misc. librarys of models.
/// 
/// This is simillar to NSUserDefaults, but with some differences.
/// - You can store and retrieve models.
/// - You have domains, and containers as a way to catagorize
public class KVStore {
    public var domains: [String : KVStoreDomain] = [:]
    
    public subscript(key: String) -> KVStoreDomain? {
        return domain(forKey: key)
    }
    
    public func addDomain(key: String, domain: KVStoreDomain = KVStoreDomain()) -> KVStoreDomain {
        self.domains[key] = domain
        return domain
    }
    
    public func domain(forKey key: String) -> KVStoreDomain? {
        guard let domain = domains[key] else { return nil }
        return domain
    }
    
    public init() {}
}

public class KVStoreDomain {
    
    /// The store containers contained in the domain
    public var containers : [String : KVStoreContainer] = [:]
    
    /// Returns the container for the key for nil if not found
    public subscript(key: String) -> KVStoreContainer? {
        return container(forKey: key)
    }
    
    /// Returns the container for the key for nil if not found
    public func container(forKey key: String) -> KVStoreContainer? {
        return containers[key]
    }
    
    /// Add a container to the reciever
    public func addContainer(key: String, container: KVStoreContainer = KVStoreContainer()) -> KVStoreContainer {
        //TODO: must not exist
        containers[key] = container
        return container
    }
    
    public init() {}
}

public class KVStoreContainer : KVEncoder, KVDecoder {
    
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
    
    /// Initialize a new KVContainer with data
    public init(data: [String : AnyObject] =  [:]) {
        self.data = data
        set(value: KVStoreVersionKey, forKey: KVStoreVersion)
    }
    
    /// Initialize a new KVContainer from a file
    public init?(_ format: Format, path: String) {
        
        if let d =  format.converter.read(path) {
            self.data = d
        } else { return nil }
    }
    
    /// Save store to a file
    public func save(format: Format, path: String) -> Bool {
        return format.converter.write(self.data, path: path)
    }

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
