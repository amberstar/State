
//
// AUTO GENERATED FILE
// _TestMigrationV2.swift
//

import Foundation
import State

public struct TestMigrationV2 : Model {
    public var age: Int?
    public var name: String

}

extension TestMigrationV2  {

    public init?(with source: Store) {
        let store = TestMigrationV2.migrate(source: source)

         guard
            let name: String = store.value(forKey: "name")
         else { return  nil }

        let age: Int? = store.value(forKey: "age")

        self.age = age
        self.name = name
        finishReading(from: store)
    }

    public func write(to store: inout Store) {
        store.set(age, forKey: "age")
        store.set(name, forKey: "name")

        TestMigrationV2.writeVersion(to: &store)
        finishWriting(to: &store)
    }
}

