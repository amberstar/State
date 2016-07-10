/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestMigrationV2 : Model {
    public var age: Int?
    public var name: String

}

extension TestMigrationV2  {

   public static func read(from store: Store) -> TestMigrationV2? {
      return self.init(with: store)
   }

    public init?(with inStore: Store) {
        let store = TestMigrationV2.migrateIfNeeded(with: inStore)

         guard
            let name: String = store.value(forKey: "name")
         else { return  nil }

        let age: Int? = store.value(forKey: "age")

        self.age = age
        self.name = name
        finishReading(from: store)
    }

    public func write(to store: inout Store) {
        store.set(age, forKey: "age")
        store.set(name, forKey: "name")

        TestMigrationV2.writeVersion(with: store)
        finishWriting(to: &store)
    }
}

