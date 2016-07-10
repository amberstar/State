/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestDictionaryComposition : Model {
    public var employees: [String : Employee]

}

extension TestDictionaryComposition  {

   public static func read(from store: Store) -> TestDictionaryComposition? {
      return self.init(with: store)
   }

    public init?(with inStore: Store) {
        let store = TestDictionaryComposition.migrateIfNeeded(with: inStore)

         guard
            let employees: [String : Employee] = store.value(forKey: "employees")
         else { return  nil }

        self.employees = employees
        finishReading(from: store)
    }

    public func write(to store: inout Store) {
        store.set(employees, forKey: "employees")

        TestDictionaryComposition.writeVersion(with: store)
        finishWriting(to: &store)
    }
}

