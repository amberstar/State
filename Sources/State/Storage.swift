//
//  Storable.swift
//  State
//
//  Created by Amber Star on 9/23/16.
//  Copyright © 2016 Amber Star. All rights reserved.
//

import Foundation

public protocol Storable {
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

}



extension  Storable {
    
    // default implementation does nothing
    public func finishReading(from: Store) {}
    
    // default implementation does nothing
    public func finishWriting(to: inout Store) {}
    
    
    public func write(to file: URL, format: Format) {
        
    }
}
