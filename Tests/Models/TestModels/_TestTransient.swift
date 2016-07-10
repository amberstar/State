/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestTransient : Model {
    public var myNonTransient: String
    public var myTransientOptional: Double?
    public var myTransientRelationship = Gender.female

}

extension TestTransient  {

   public static func read(from store: Store) -> TestTransient? {
      return self.init(with: store)
   }

    public init?(with inStore: Store) {
        let store = TestTransient.migrateIfNeeded(with: inStore)

         guard
            let myNonTransient: String = store.value(forKey: "myNonTransient")
         else { return  nil }

        self.myNonTransient = myNonTransient
        finishReading(from: store)
    }

    public func write(to store: inout Store) {
        store.set(myNonTransient, forKey: "myNonTransient")

        TestTransient.writeVersion(with: store)
        finishWriting(to: &store)
    }
}

