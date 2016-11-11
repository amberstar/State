
//
// AUTO GENERATED FILE
// _TestTransient.swift
//

import Foundation
import State

public struct TestTransient : Model  {
    public var myNonTransient: String
    public var myTransientOptional: Double?
    public var myTransientRelationship = Gender.female

}

extension TestTransient  {

    public init?(with source: Store) {
        let store = TestTransient.migrate(source: source)

         guard
            let myNonTransient: String = store.value(forKey: "myNonTransient")
         else { return  nil }

        self.myNonTransient = myNonTransient
        finishReading(from: store)
    }

// MARK: - Storeable

    public static func restore(from store: Store) -> TestTransient? {
        return self.init(with: store)
    }

    public func store(to store: inout Store) {
        store.set(myNonTransient, forKey: "myNonTransient")

        TestTransient.writeVersion(to: &store)
        finishWriting(to: &store)
    }
}

