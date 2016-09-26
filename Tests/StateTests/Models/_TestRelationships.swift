
//
// AUTO GENERATED FILE
// _TestRelationships.swift
//

import Foundation
import State

public struct TestRelationships : Model {
    public var myChildren: [TestChild]?
    public var myGrandChildren: [Grandchild]?
    public var myOneChild: TestChild?

}

extension TestRelationships  {

    public init?(with source: Store) {
        let store = TestRelationships.migrate(source: source)

        let myChildren: [TestChild]? = store.value(forKey: "myChildren")
        let myGrandChildren: [Grandchild]? = store.value(forKey: "myGrandChildren")
        let myOneChild: TestChild? = store.value(forKey: "myOneChild")

        self.myChildren = myChildren
        self.myGrandChildren = myGrandChildren
        self.myOneChild = myOneChild
        finishReading(from: store)
    }

    public func write(to store: inout Store) {
        store.set(myChildren, forKey: "myChildren")
        store.set(myGrandChildren, forKey: "myGrandChildren")
        store.set(myOneChild, forKey: "myOneChild")

        TestRelationships.writeVersion(to: &store)
        finishWriting(to: &store)
    }
}

