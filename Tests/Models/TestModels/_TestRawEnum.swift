/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public enum TestRawEnum  : String, Model {

    case aim  = "Aim"
    case fire  = "Fire"
    case ready  = "Ready"

}

extension TestRawEnum {

    public static func read(from store: Store) -> TestRawEnum? {
      return self.init(with: store)
   }

    public init?(with inStore: Store) {
        let store = TestRawEnum.migrate(source: inStore)

        guard let value: String = store.value(forKey: "value") else { return nil }
        self.init(rawValue: value)
    }

    public func write(to store: inout Store) {
        store.set(self.rawValue, forKey: "value")
            TestRawEnum.writeVersion(to: &store)
            finishWriting(to: &store)
    }
}

