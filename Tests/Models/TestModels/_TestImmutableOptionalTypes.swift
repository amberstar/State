/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestImmutableOptionalTypes : Model {
    public let myDate: NSDate?
    public let myFloat: Float?
    public let myBinary: NSData?
    public let myDouble: Double?
    public let myString: String?
    public let myBoolean: Bool?
    public let myDecimal: NSDecimalNumber?
    public let myInt: Int?

}

extension TestImmutableOptionalTypes  {

    public static func read(from store: Store) -> TestImmutableOptionalTypes? {
      return self.init(with: store)
   }

    public init?(with inStore: Store) {
        let store = TestImmutableOptionalTypes.migrate(source: inStore)

        let myDate: NSDate? = store.value(forKey: "myDate")
        let myFloat: Float? = store.value(forKey: "myFloat")
        let myBinary: NSData? = store.value(forKey: "myBinary")
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

    public func write(to store: inout Store) {
        store.set(myDate, forKey: "myDate")
        store.set(myFloat, forKey: "myFloat")
        store.set(myBinary, forKey: "myBinary")
        store.set(myDouble, forKey: "myDouble")
        store.set(myString, forKey: "myString")
        store.set(myBoolean, forKey: "myBoolean")
        store.set(myDecimal, forKey: "myDecimal")
        store.set(myInt, forKey: "myInt")

        TestImmutableOptionalTypes.writeVersion(to: store)
        finishWriting(to: &store)
    }
}

