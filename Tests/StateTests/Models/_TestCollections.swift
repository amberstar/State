
//
// AUTO GENERATED FILE
// _TestCollections.swift
//

import Foundation
import State

public struct TestCollections : Model  {
    public var setOfStrings: Set<String>
    public var dicOfInts: [String : Int]
    public var arrayOfStrings: [String]

}

extension TestCollections  {

    public init?(with source: Store) {
        let store = TestCollections.migrate(source: source)

         guard
            let setOfStrings: Set<String> = store.value(forKey: "setOfStrings"),
            let dicOfInts: [String : Int] = store.value(forKey: "dicOfInts"),
            let arrayOfStrings: [String] = store.value(forKey: "arrayOfStrings")
         else { return  nil }

        self.setOfStrings = setOfStrings
        self.dicOfInts = dicOfInts
        self.arrayOfStrings = arrayOfStrings
        finishReading(from: store)
    }

// MARK: - Storeable

    public static func restore(from store: Store) -> TestCollections? {
        return self.init(with: store)
    }

    public func store(to store: inout Store) {
        store.set(setOfStrings, forKey: "setOfStrings")
        store.set(dicOfInts, forKey: "dicOfInts")
        store.set(arrayOfStrings, forKey: "arrayOfStrings")

        TestCollections.writeVersion(to: &store)
        finishWriting(to: &store)
    }
}

