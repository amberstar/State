/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct Grandchild : Model {
    public var age: Int?
    public var name: String?
    public var gender: Gender?

}

extension Grandchild  {

    public static func read(from store: Store) -> Grandchild? {
      return self.init(with: store)
   }

    public init?(with inStore: Store) {
        let store = Grandchild.migrate(from: inStore)

        let age: Int? = store.value(forKey: "age")
        let name: String? = store.value(forKey: "name")
        let gender: Gender? = store.value(forKey: "gender")

        self.age = age
        self.name = name
        self.gender = gender
        finishReading(from: store)
    }

    public func write(to store: inout Store) {
        store.set(age, forKey: "age")
        store.set(name, forKey: "name")
        store.set(gender, forKey: "gender")

        Grandchild.writeVersion(to: store)
        finishWriting(to: &store)
    }
}

