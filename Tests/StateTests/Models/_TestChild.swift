
//
// AUTO GENERATED FILE
// _TestChild.swift
//

import Foundation
import State

public struct TestChild : Model  {
    public var age: Int?
    public var name: String?
    public var myChildren: [Grandchild]?
    public var gender: Gender?

}

extension TestChild  {

    public init?(with source: Store) {
        let store = TestChild.migrate(source: source)

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

// MARK: - Storeable

    public static func restore(from store: Store) -> TestChild? {
        return self.init(with: store)
    }

    public func store(to store: inout Store) {
        store.set(age, forKey: "age")
        store.set(name, forKey: "name")
        store.set(myChildren, forKey: "myChildren")
        store.set(gender, forKey: "gender")

        TestChild.writeVersion(to: &store)
        finishWriting(to: &store)
    }
}

