
//
// AUTO GENERATED FILE
// _TestTransient2.swift
//

import Foundation
import State

public struct TestTransient2 : Model  {
    public var transient2: Int?
    public var transient1: String?
    public var myNonTransient: Gender?

}

extension TestTransient2  {

    public init?(with source: Store) {
        let store = TestTransient2.migrate(source: source)

        let myNonTransient: Gender? = store.value(forKey: "myNonTransient")

        self.myNonTransient = myNonTransient
        finishReading(from: store)
    }

// MARK: - Storeable

    public static func restore(from store: Store) -> TestTransient2? {
        return self.init(with: store)
    }

    public func store(to store: inout Store) {
        store.set(myNonTransient, forKey: "myNonTransient")

        TestTransient2.writeVersion(to: &store)
        finishWriting(to: &store)
    }
}

