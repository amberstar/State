/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestChild : Model {
    public var age: Int?
    public var name: String?
    public var myChildren: [Grandchild]?
    public var gender: Gender?

}

extension TestChild  {

    public static func read(from store: Store) -> TestChild? {
      return self.init(with: store)
   }

    public init?(with inStore: Store) {
        let store = TestChild.migrate(from: inStore)

        let age: Int? = store.value(forKey: "age")
        let name: String? = store.value(forKey: "name")
        let myChildren: [Grandchild]? = store.value(forKey: "myChildren")
        let gender: Gender? = store.value(forKey: "gender")

        self.age = age
        self.name = name
        self.myChildren = myChildren
        self.gender = gender
        finishReading(from: store)
    }

    public func write(to store: inout Store) {
        store.set(age, forKey: "age")
        store.set(name, forKey: "name")
        store.set(myChildren, forKey: "myChildren")
        store.set(gender, forKey: "gender")

        TestChild.writeVersion(to: store)
        finishWriting(to: &store)
    }
}

