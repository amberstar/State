/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestDefaultsChild : Model {
    public var name = "New Child"

}

extension TestDefaultsChild  {

   public static func read(from store: Store) -> TestDefaultsChild? {
      return self.init(with: store)
   }

    public init?(with inStore: Store) {
        let store = TestDefaultsChild.migrateIfNeeded(with: inStore)

         guard
            let name: String = store.value(forKey: "name")
         else { return  nil }

        self.name = name
        finishReading(from: store)
    }

    public func write(to store: inout Store) {
        store.set(name, forKey: "name")

        TestDefaultsChild.writeVersion(with: store)
        finishWriting(to: &store)
    }
}

