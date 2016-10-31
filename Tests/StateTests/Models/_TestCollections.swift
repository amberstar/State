
//
// AUTO GENERATED FILE
// _TestCollections.swift
//

import Foundation
import State

public struct TestCollections : Model {
    public var arrayOfStrings: [String]
    public var dicOfInts: [String : Int]
    public var setOfStrings: Set<String>

}

extension TestCollections  {

    public init?(with source: Store) {
        let store = TestCollections.migrate(source: source)

         guard
            let arrayOfStrings: [String] = store.value(forKey: "arrayOfStrings"),
            let dicOfInts: [String : Int] = store.value(forKey: "dicOfInts"),
            let setOfStrings: Set<String> = store.value(forKey: "setOfStrings")
         else { return  nil }

        self.arrayOfStrings = arrayOfStrings
        self.dicOfInts = dicOfInts
        self.setOfStrings = setOfStrings
        finishReading(from: store)
    }

// MARK: - Storeable

    public static func restore(from store: Store) -> TestCollections? {
        return self.init(with: store)
    }

    public func store(to store: inout Store) {
        store.set(arrayOfStrings, forKey: "arrayOfStrings")
        store.set(dicOfInts, forKey: "dicOfInts")
        store.set(setOfStrings, forKey: "setOfStrings")

        TestCollections.writeVersion(to: &store)
        finishWriting(to: &store)
    }
}

