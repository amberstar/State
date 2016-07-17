/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State
import UIKit

public enum TestAssociatedOptionalEnum  : Model {

    case binaryType (NSData?)
    case booleanType (Bool?)
    case dateType (NSDate?)
    case decimalType (NSDecimalNumber?)
    case doubleType (Double?)
    case floatType (Float?)
    case intType (Int?)
    case stringType (String?)
    case transformableColorType (UIColor?)
    case decodableToManyType ([Employee]?)
    case decodableToOneType (Employee?)

}

extension TestAssociatedOptionalEnum {

    public static func read(from store: Store) -> TestAssociatedOptionalEnum? {
      return self.init(with: store)
   }

    public init?(with inStore: Store) {
        let store = TestAssociatedOptionalEnum.migrate(from: inStore)

        guard let type: String = store.value(forKey: "TestAssociatedOptionalEnum") else { return nil }
        switch type {
                case "binaryType":
                   let value: NSData? = store.value(forKey: "value")
                self = TestAssociatedOptionalEnum.binaryType(value)

                case "booleanType":
                   let value: Bool? = store.value(forKey: "value")
                self = TestAssociatedOptionalEnum.booleanType(value)

                case "dateType":
                   let value: NSDate? = store.value(forKey: "value")
                self = TestAssociatedOptionalEnum.dateType(value)

                case "decimalType":
                   let value: NSDecimalNumber? = store.value(forKey: "value")
                self = TestAssociatedOptionalEnum.decimalType(value)

                case "doubleType":
                   let value: Double? = store.value(forKey: "value")
                self = TestAssociatedOptionalEnum.doubleType(value)

                case "floatType":
                   let value: Float? = store.value(forKey: "value")
                self = TestAssociatedOptionalEnum.floatType(value)

                case "intType":
                   let value: Int? = store.value(forKey: "value")
                self = TestAssociatedOptionalEnum.intType(value)

                case "stringType":
                   let value: String? = store.value(forKey: "value")
                self = TestAssociatedOptionalEnum.stringType(value)

                case "transformableColorType":
                   let value: UIColor? = store.value(forKey: "value")
                self = TestAssociatedOptionalEnum.transformableColorType(value)

                case "decodableToManyType":
                    let value: [Employee]? = store.value(forKey: "value")
self = TestAssociatedOptionalEnum.decodableToManyType(value)

                case "decodableToOneType":
                    let value: Employee? = store.value(forKey: "value")
self = TestAssociatedOptionalEnum.decodableToOneType(value)

                default:
                    return nil
        }

    }

    public func write(to store: inout Store) {

        switch self {
            case let .binaryType(value):
                store.set("binaryType", forKey: "TestAssociatedOptionalEnum")
                store.set(value, forKey: "value")
            case let .booleanType(value):
                store.set("booleanType", forKey: "TestAssociatedOptionalEnum")
                store.set(value, forKey: "value")
            case let .dateType(value):
                store.set("dateType", forKey: "TestAssociatedOptionalEnum")
                store.set(value, forKey: "value")
            case let .decimalType(value):
                store.set("decimalType", forKey: "TestAssociatedOptionalEnum")
                store.set(value, forKey: "value")
            case let .doubleType(value):
                store.set("doubleType", forKey: "TestAssociatedOptionalEnum")
                store.set(value, forKey: "value")
            case let .floatType(value):
                store.set("floatType", forKey: "TestAssociatedOptionalEnum")
                store.set(value, forKey: "value")
            case let .intType(value):
                store.set("intType", forKey: "TestAssociatedOptionalEnum")
                store.set(value, forKey: "value")
            case let .stringType(value):
                store.set("stringType", forKey: "TestAssociatedOptionalEnum")
                store.set(value, forKey: "value")
            case let .transformableColorType(value):
                store.set("transformableColorType", forKey: "TestAssociatedOptionalEnum")
                store.set(value, forKey: "value")
            case let .decodableToManyType(value):
                store.set("decodableToManyType", forKey: "TestAssociatedOptionalEnum")
                store.set(value, forKey: "value")
            case let .decodableToOneType(value):
                store.set("decodableToOneType", forKey: "TestAssociatedOptionalEnum")
                store.set(value, forKey: "value")

        }

            TestAssociatedOptionalEnum.writeVersion(to: store)
            finishWriting(to: &store)
    }
}

