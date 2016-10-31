
//
// AUTO GENERATED FILE
// _TestOptionalTypes.swift
//

import Foundation
import State

public struct TestOptionalTypes : Model {
    public var myDate: Date?
    public var myFloat: Float?
    public var myBinary: Data?
    public var myDouble: Double?
    public var myString: String?
    public var myBoolean: Bool?
    public var myDecimal: NSDecimalNumber?
    public var myInt: Int?

}

extension TestOptionalTypes  {

    public init?(with source: Store) {
        let store = TestOptionalTypes.migrate(source: source)

        let myDate: Date? = store.value(forKey: "myDate")
        let myFloat: Float? = store.value(forKey: "myFloat")
        let myBinary: Data? = store.value(forKey: "myBinary")
        let myDouble: Double? = store.value(forKey: "myDouble")
        let myString: String? = store.value(forKey: "myString")
        let myBoolean: Bool? = store.value(forKey: "myBoolean")
        let myDecimal: NSDecimalNumber? = store.value(forKey: "myDecimal")
        let myInt: Int? = store.value(forKey: "myInt")

        self.myDate = myDate
        self.myFloat = myFloat
        self.myBinary = myBinary
        self.myDouble = myDouble
        self.myString = myString
        self.myBoolean = myBoolean
        self.myDecimal = myDecimal
        self.myInt = myInt
        finishReading(from: store)
    }

// MARK: - Storeable

    public static func restore(from store: Store) -> TestOptionalTypes? {
        return self.init(with: store)
    }

    public func store(to store: inout Store) {
        store.set(myDate, forKey: "myDate")
        store.set(myFloat, forKey: "myFloat")
        store.set(myBinary, forKey: "myBinary")
        store.set(myDouble, forKey: "myDouble")
        store.set(myString, forKey: "myString")
        store.set(myBoolean, forKey: "myBoolean")
        store.set(myDecimal, forKey: "myDecimal")
        store.set(myInt, forKey: "myInt")

        TestOptionalTypes.writeVersion(to: &store)
        finishWriting(to: &store)
    }
}

