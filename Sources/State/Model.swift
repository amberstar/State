
//
// Model.swift
// Copyright © 2016 Amber Star. All rights reserved.
//

import Foundation

///  A storable with version and migration
///  useful for domain entities.
///
///  Models are storable so collections of them can be
///  written and read to json and plist files, converted
///  formatted to `Strings`, or `Data`. 
///  They have methods to support migration and versioning.
/// 
///  Migration
///  ==========
///  To support migration:
/// 
///  * implement `static func writeVersion(with: Store)`
/// 
///    this method should be called in the `write(to:)` method
///    before writing to a store is finished to give the model an
///    opportunity to write version information to the store.
/// 
///  * implement `static func migrate(from: Store) -> Store`
/// 
///    this method should be called in the `read(from:)` method
///    before reading any values from the store to give the model
///    an opportunity to migrate the store. Here the model should:
/// 
///    -  read the version information from the store
///    -  compare the version information with the "current version"
///    -  add, remove, and update keys, and values to the store
///    -  return the updated store.
/// 
///    In the `read(from:)` method use the migrated store to read
///    and instantiate the model instance.
public protocol Model: Storable {
    
    /// called after reading is finished
    /// to give a model an opportunity
    /// to prepare or to read extra values
    /// from the store before instantiation
    func finishReading(from: Store)
    /// called before writing is finished
    /// to give the model an opportunity
    /// to write extra values to the store
    func finishWriting(to: inout Store)
    /// writes the model version to the store.
    /// 
    /// This is called before writing a model to
    /// a store is complete to give the model
    /// an opportunity to write version information
    /// to the store for migration purposes.
    static func writeVersion(to: inout Store)
    /// migrates a store to the current version if needed.
    /// 
    /// the default implementation returns the original store
    /// models can update the store to the current version
    /// by adding, removing, and changing keys ans values in the
    /// store, and return the updated store.
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
