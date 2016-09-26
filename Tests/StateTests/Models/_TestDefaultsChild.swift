
//
// AUTO GENERATED FILE
// _TestDefaultsChild.swift
//

import Foundation
import State

public struct TestDefaultsChild : Model {
    public var name = "New Child"

}

extension TestDefaultsChild  {

    public init?(with source: Store) {
        let store = TestDefaultsChild.migrate(source: source)

         guard
            let name: String = store.value(forKey: "name")
         else { return  nil }

        self.name = name
        finishReading(from: store)
    }

    public func write(to store: inout Store) {
        store.set(name, forKey: "name")

        TestDefaultsChild.writeVersion(to: &store)
        finishWriting(to: &store)
    }
}

