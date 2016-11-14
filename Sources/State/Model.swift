
//
// Model.swift
// Copyright © 2016 Amber Star. All rights reserved.
//

import Foundation

///  A storable type with version and migration methods
///  useful for domain entities.
///
///  Models are storable. Instances and collections of them can be
///  written and read to json and plist files, or 
///  formatted to `Strings`, and `Data` types. 
///  They have methods to support migration and versioning.
public protocol Model: Storable {
    
    /// Finish reading from a store.
    ///
    /// Optionally call this method after restoring from the store
    /// in the `restore(from:) method if the model
    /// needs to read extra properties from the store 
    /// before it is instantiated.
    func finishReading(from: Store)
    /// Finish writing to a store.
    ///
    /// Optionally call this method after storing 
    /// a model in the `store(to:)` method when
    /// the model needs to store addional properties.
    func finishWriting(to: inout Store)
    /// Writes the model version to the store.
    /// 
    /// Optionally call this method after storing a model 
    /// in the `store(to:)` method to write version 
    /// information to the store for migration purposes.
    static func writeVersion(to: inout Store)
    /// Migrates a store to the current version if needed.
    /// 
    /// Optionally call this method before restoring a model
    /// in the `restore(from:)` method to migrate the model. 
    /// Use previously stored version information to determine 
    /// if migration is nessesarry.
    ///
    /// In this method you can add, remove, or update properties
    /// in the store as needed to update the model prior to
    /// restoring.
    ///  
    /// To support migration:
    /// 
    /// * implement `static func writeVersion(with: Store)`
    /// 
    ///   this method should be called in the `store(to:)` method
    ///   before writing to a store is finished to give the model an
    ///   opportunity to write version information to the store.
    /// 
    /// * implement `static func migrate(from: Store) -> Store`
    /// 
    ///   this method should be called in the `restore(from:)` method
    ///   before reading any values from the store to give the model
    ///   an opportunity to migrate the store. Here the model should:
    /// 
    ///   -  read the version information from the store
    ///   -  compare the version information with the "current version"
    ///   -  add, remove, and update keys, and values to the store
    ///   -  return the updated store.
    /// 
    ///  In the `restore(from:)` method use the migrated store to read
    ///  and instantiate the model instance.
    static func migrate(source: Store) -> Store
}

// note: these default implementations do nothing
public extension Model {

    // default implementation does nothing
    static func migrate(source: Store) -> Store {
        return source
    }
    // default implementation does nothing
    static func writeVersion(to: inout Store) {}

    // default implementation does nothing
    func finishReading(from: Store) {}
    
    // default implementation does nothing
    func finishWriting(to: inout Store) {}
}
