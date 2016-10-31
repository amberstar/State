
//
// AUTO GENERATED FILE
// _Gender.swift
//

import Foundation
import State

public enum Gender  : String, Model {

    case female  = "female"
    case male  = "male"

}

extension Gender {

    public init?(with source: Store) {
        let store = Gender.migrate(source: source)

        guard let value: String = store.value(forKey: "value") else { return nil }
        self.init(rawValue: value)
    }

// MARK: - Storeable

    public static func restore(from store: Store) -> Gender? {
        return self.init(with: store)
    }

    public func store(to store: inout Store) {
        store.set(self.rawValue, forKey: "value")
            Gender.writeVersion(to: &store)
            finishWriting(to: &store)
    }
}

