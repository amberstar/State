
//
// AUTO GENERATED FILE
// _TestProtocolContainter.swift
//

import Foundation
import State

public struct TestProtocolContainter : Model  {
    public var testProtocol: TestProtocol
    public var testProtocolsDict: [String : TestParentProtocol]
    public var testProtocols: [TestParentProtocol]

}

extension TestProtocolContainter  {

    public init?(with source: Store) {
        let store = TestProtocolContainter.migrate(source: source)

         guard
            let testProtocol: TestProtocol = store.value(forKey: "testProtocol"),
            let testProtocolsDict: [String : TestParentProtocol] = store.value(forKey: "testProtocolsDict"),
            let testProtocols: [TestParentProtocol] = store.value(forKey: "testProtocols")
         else { return  nil }

        self.testProtocol = testProtocol
        self.testProtocolsDict = testProtocolsDict
        self.testProtocols = testProtocols
        finishReading(from: store)
    }

// MARK: - Storeable

    public static func restore(from store: Store) -> TestProtocolContainter? {
        return self.init(with: store)
    }

    public func store(to store: inout Store) {
        store.set(testProtocol, forKey: "testProtocol")
        store.set(testProtocolsDict, forKey: "testProtocolsDict")
        store.set(testProtocols, forKey: "testProtocols")

        TestProtocolContainter.writeVersion(to: &store)
        finishWriting(to: &store)
    }
}

