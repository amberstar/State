
//
// AUTO GENERATED FILE
// _TestDictionaryComposition.swift
//

import Foundation
import State

public struct TestDictionaryComposition : Model  {
    public var employees: [String : Employee]

}

extension TestDictionaryComposition  {

    public init?(with source: Store) {
        let store = TestDictionaryComposition.migrate(source: source)

         guard
            let employees: [String : Employee] = store.value(forKey: "employees")
         else { return  nil }

        self.employees = employees
        finishReading(from: store)
    }

// MARK: - Storeable

    public static func restore(from store: Store) -> TestDictionaryComposition? {
        return self.init(with: store)
    }

    public func store(to store: inout Store) {
        store.set(employees, forKey: "employees")

        TestDictionaryComposition.writeVersion(to: &store)
        finishWriting(to: &store)
    }
}

