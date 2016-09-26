
//
// AUTO GENERATED FILE
// _TestProtocolContainter.swift
//

import Foundation
import State

public struct TestProtocolContainter : Model {
    public var testProtocol: TestProtocol
    public var testProtocols: [TestParentProtocol]
    public var testProtocolsDict: [String : TestParentProtocol]

}

extension TestProtocolContainter  {

    public init?(with source: Store) {
        let store = TestProtocolContainter.migrate(source: source)

         guard
            let testProtocol: TestProtocol = store.value(forKey: "testProtocol"),
            let testProtocols: [TestParentProtocol] = store.value(forKey: "testProtocols"),
            let testProtocolsDict: [String : TestParentProtocol] = store.value(forKey: "testProtocolsDict")
         else { return  nil }

        self.testProtocol = testProtocol
        self.testProtocols = testProtocols
        self.testProtocolsDict = testProtocolsDict
        finishReading(from: store)
    }

    public func write(to store: inout Store) {
        store.set(testProtocol, forKey: "testProtocol")
        store.set(testProtocols, forKey: "testProtocols")
        store.set(testProtocolsDict, forKey: "testProtocolsDict")

        TestProtocolContainter.writeVersion(to: &store)
        finishWriting(to: &store)
    }
}

