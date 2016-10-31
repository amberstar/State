
//
// AUTO GENERATED FILE
// _TestTransient3.swift
//

import Foundation
import State

public struct TestTransient3 : Model {
    public var myNonTransient1: Double?
    public var myNonTransient2: String?
    public var myTransientRelationship: Gender?

}

extension TestTransient3  {

    public init?(with source: Store) {
        let store = TestTransient3.migrate(source: source)

        let myNonTransient1: Double? = store.value(forKey: "myNonTransient1")
        let myNonTransient2: String? = store.value(forKey: "myNonTransient2")

        self.myNonTransient1 = myNonTransient1
        self.myNonTransient2 = myNonTransient2
        finishReading(from: store)
    }

// MARK: - Storeable

    public static func restore(from store: Store) -> TestTransient3? {
        return self.init(with: store)
    }

    public func store(to store: inout Store) {
        store.set(myNonTransient1, forKey: "myNonTransient1")
        store.set(myNonTransient2, forKey: "myNonTransient2")

        TestTransient3.writeVersion(to: &store)
        finishWriting(to: &store)
    }
}

