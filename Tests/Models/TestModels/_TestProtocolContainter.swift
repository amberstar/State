/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestProtocolContainter : Model {
    public var testProtocol: TestProtocol
    public var testProtocols: [TestParentProtocol]
    public var testProtocolsDict: [String : TestParentProtocol]

}

extension TestProtocolContainter  {

    public static func read(from store: Store) -> TestProtocolContainter? {
      return self.init(with: store)
   }

    public init?(with inStore: Store) {
        let store = TestProtocolContainter.migrate(from: inStore)

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

        TestProtocolContainter.writeVersion(to: store)
        finishWriting(to: &store)
    }
}

