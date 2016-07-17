/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestTransient2 : Model {
    public var transient2: Int?
    public var transient1: String?
    public var myNonTransient: Gender?

}

extension TestTransient2  {

    public static func read(from store: Store) -> TestTransient2? {
      return self.init(with: store)
   }

    public init?(with inStore: Store) {
        let store = TestTransient2.migrate(from: inStore)

        let myNonTransient: Gender? = store.value(forKey: "myNonTransient")

        self.myNonTransient = myNonTransient
        finishReading(from: store)
    }

    public func write(to store: inout Store) {
        store.set(myNonTransient, forKey: "myNonTransient")

        TestTransient2.writeVersion(to: store)
        finishWriting(to: &store)
    }
}

