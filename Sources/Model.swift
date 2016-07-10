
//
// State: Sources/Model.swift
// Copyright © 2016 SIMPLETOUCH LLC. All rights reserved.
//
// Licensed under The MIT License (MIT)
//

/// Model - API
///
/// Models read and write themselves to a `Store`
/// by implementing the `Model` protocol.


/// MIGRATION SUPPORT:
///
/// Migration is an opt-in feature, by default
/// models will not participate in migration.
///
/// To support migration:
///
///  * implement `static func writeVersion(with: Store)`
///
///     this function should be called in the `write(to:)` method
///     before writing to a store is finished to give models an 
///     opertunity to write version information to the store.
///
/// * implement `static func migrateIfNeeded(with: Store) -> Store`
///
///     this function should be called in the `read(from:)` method
///     before reading to give the model an opertunity to migrate
///     the model to the current version. Here the model should:
///
///    -  read the version information from the store
///    -  compare the version information with the "current version"
///    -  add, remove, and update keys, and values as needed migrate
///    -  return the updated store. 
///    
///   in the `read(from:)` method use the migrated store to read
///   and instantiate the model instance.


import Foundation

/// A type that can be read and written to a `Store`.
public protocol Model {
    
    /// creates a `Model` instance from
    /// a store.
    static func read(from: Store) -> Self?
    
    /// called after reading is finished
    /// to give a model an opertunity
    /// to prepare or to read extra values
    /// from the store before instantiation
    func finishReading(from: Store)
    
    /// Writes the`Model` to a `Store`
    func write(to: inout Store)
    
    /// called before writing is finished
    /// to give the model an opertunity
    /// to write extra values to the store
    func finishWriting(to: inout Store)
    
    /// writes the model version to the store.
    ///
    /// This is called before writing a model to 
    /// a store is complete to give the model
    /// an opertunity to write version information
    /// to the store for migration purporses.
    static func writeVersion(with: Store)
    
    /// migrates a store to the current version if needed.
    ///
    /// the default implementation returns the origional store
    /// models can update the store to the current version
    /// by adding, removing, and changing keys ans values in the
    /// store, and return the updated store.
    static func migrateIfNeeded(with: Store) -> Store
}

extension Model {
  
   
    /// Initialize a `Model` from a file
    public init?(file: URL, format: Format) {
        guard let data = format.formatter.read(file) else { return nil }
        guard let instance = Self.read(from: DataStore(data: data)) else { return nil }
        self = instance
    }
    
    /// Writes a model to a file
    ///
    /// - Returns: `true` if succeeded otherwise `false`
    public func write(to file: URL, format: Format) -> Bool {
        var vstore : Store = DataStore()
        self.write(to: &vstore)
        return format.formatter.write((vstore as! DataStore).data, to: file)
    }
    
    // The following default implementations do nothing to provide them as optional.
    
    public static func migrateIfNeeded(with store: Store) -> Store {
        return store
    }
    
    public static func writeVersion(with: Store) { } // default implementation does nothing
    public func finishReading(from: Store)  { } // default implementation does nothing
    public func finishWriting(to: inout Store) { } // default implementation does nothing

}
