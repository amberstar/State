
//
// AUTO GENERATED FILE
// _Employee.swift
//

import Foundation
import State

public struct Employee : Model {
    public var name: String
    public var title: String?

}

extension Employee  {

    public static func read(from store: Store) -> Employee? {
      return self.init(with: store)
   }

    public init?(with inStore: Store) {
        let store = Employee.migrate(source: inStore)

         guard
            let name: String = store.value(forKey: "name")
         else { return  nil }

        let title: String? = store.value(forKey: "title")

        self.name = name
        self.title = title
        finishReading(from: store)
    }

    public func write(to store: inout Store) {
        store.set(name, forKey: "name")
        store.set(title, forKey: "title")

        Employee.writeVersion(to: &store)
        finishWriting(to: &store)
    }
}

