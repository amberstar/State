/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestTransformable : Model {
    public var myTransformable: NSURL
    public let myTransformableImmutable: NSURL
    public let myTransformableImmutableOptional: NSURL?
    public var myTransformableOptional: NSURL?

}

extension TestTransformable  {

   public static func read(from store: Store) -> TestTransformable? {
      return self.init(with: store)
   }

    public init?(with inStore: Store) {
        let store = TestTransformable.migrateIfNeeded(with: inStore)

         guard
            let myTransformable: NSURL = store.value(forKey: "myTransformable"),
            let myTransformableImmutable: NSURL = store.value(forKey: "myTransformableImmutable")
         else { return  nil }

        let myTransformableImmutableOptional: NSURL? = store.value(forKey: "myTransformableImmutableOptional")
        let myTransformableOptional: NSURL? = store.value(forKey: "myTransformableOptional")

        self.myTransformable = myTransformable
        self.myTransformableImmutable = myTransformableImmutable
        self.myTransformableImmutableOptional = myTransformableImmutableOptional
        self.myTransformableOptional = myTransformableOptional
        finishReading(from: store)
    }

    public func write(to store: inout Store) {
        store.set(myTransformable, forKey: "myTransformable")
        store.set(myTransformableImmutable, forKey: "myTransformableImmutable")
        store.set(myTransformableImmutableOptional, forKey: "myTransformableImmutableOptional")
        store.set(myTransformableOptional, forKey: "myTransformableOptional")

        TestTransformable.writeVersion(with: store)
        finishWriting(to: &store)
    }
}

