
//
// AUTO GENERATED FILE
// _TestTransformable.swift
//

import Foundation
import State

public struct TestTransformable : Model  {
    public let myTransformableImmutableOptional: URL?
    public let myTransformableImmutable: URL
    public var myTransformableOptional: URL?
    public var myTransformable: URL

}

extension TestTransformable  {

    public init?(with source: Store) {
        let store = TestTransformable.migrate(source: source)

         guard
            let myTransformableImmutable: URL = store.value(forKey: "myTransformableImmutable"),
            let myTransformable: URL = store.value(forKey: "myTransformable")
         else { return  nil }

        let myTransformableImmutableOptional: URL? = store.value(forKey: "myTransformableImmutableOptional")

        let myTransformableOptional: URL? = store.value(forKey: "myTransformableOptional")

        self.myTransformableImmutableOptional = myTransformableImmutableOptional
        self.myTransformableImmutable = myTransformableImmutable
        self.myTransformableOptional = myTransformableOptional
        self.myTransformable = myTransformable
        finishReading(from: store)
    }

// MARK: - Storeable

    public static func restore(from store: Store) -> TestTransformable? {
        return self.init(with: store)
    }

    public func store(to store: inout Store) {
        store.set(myTransformableImmutableOptional, forKey: "myTransformableImmutableOptional")
        store.set(myTransformableImmutable, forKey: "myTransformableImmutable")
        store.set(myTransformableOptional, forKey: "myTransformableOptional")
        store.set(myTransformable, forKey: "myTransformable")

        TestTransformable.writeVersion(to: &store)
        finishWriting(to: &store)
    }
}

