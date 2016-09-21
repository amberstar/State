
//
// AUTO GENERATED FILE
// _Company.swift
//

import Foundation
import State

public struct Company : Model {
    public var name: String
    public var yearFounded: Double
    public var phoneNumber: String?
    public var employees: [Employee]?

}

extension Company  {

    public static func read(from store: Store) -> Company? {
      return self.init(with: store)
   }

    public init?(with inStore: Store) {
        let store = Company.migrate(source: inStore)

         guard
            let name: String = store.value(forKey: "name"),
            let yearFounded: Double = store.value(forKey: "yearFounded")
         else { return  nil }

        let phoneNumber: String? = store.value(forKey: "phoneNumber")
        let employees: [Employee]? = store.value(forKey: "employees")

        self.name = name
        self.yearFounded = yearFounded
        self.phoneNumber = phoneNumber
        self.employees = employees
        finishReading(from: store)
    }

    public func write(to store: inout Store) {
        store.set(name, forKey: "name")
        store.set(yearFounded, forKey: "yearFounded")
        store.set(phoneNumber, forKey: "phoneNumber")
        store.set(employees, forKey: "employees")

        Company.writeVersion(to: &store)
        finishWriting(to: &store)
    }
}

