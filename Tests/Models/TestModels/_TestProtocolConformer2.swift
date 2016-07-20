/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestProtocolConformer2 : TestParentProtocol {
    public var name: String
    public var ss_number: String

}

extension TestProtocolConformer2  {

    public static func read(from store: Store) -> TestProtocolConformer2? {
      return self.init(with: store)
   }

    public init?(with inStore: Store) {
        let store = TestProtocolConformer2.migrate(source: inStore)

         guard
            let name: String = store.value(forKey: "name"),
            let ss_number: String = store.value(forKey: "ss_number")
         else { return  nil }

        self.name = name
        self.ss_number = ss_number
        finishReading(from: store)
    }

    public func write(to store: inout Store) {
        store.set(name, forKey: "name")
        store.set(ss_number, forKey: "ss_number")

        store.set("TestProtocolConformer2", forKey: "TestParentProtocol")
        TestProtocolConformer2.writeVersion(to: &store)
        finishWriting(to: &store)
    }
}

