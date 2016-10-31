
//
// AUTO GENERATED FILE
// _TestRegEnum.swift
//

import Foundation
import State

public enum TestRegEnum  : Model {

    case cold 
    case hot

}

extension TestRegEnum {

    public init?(with source: Store) {
        let store = TestRegEnum.migrate(source: source)

        guard let type: String = store.value(forKey: "TestRegEnum") else { return nil }
        switch type {
                case "cold":
                   self = TestRegEnum.cold
                case "hot":
                   self = TestRegEnum.hot

                default:
                    return nil
        }

    }

// MARK: - Storeable

    public static func restore(from store: Store) -> TestRegEnum? {
        return self.init(with: store)
    }

    public func store(to store: inout Store) {

        switch self {
            case .cold:
                store.set("cold", forKey: "TestRegEnum")
            case .hot:
                store.set("hot", forKey: "TestRegEnum")

        }

            TestRegEnum.writeVersion(to: &store)
            finishWriting(to: &store)
    }
}

