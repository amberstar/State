
//
// AUTO GENERATED FILE
// _TestAssociatedEnum.swift
//

import Foundation
import State
import UIKit

public enum TestAssociatedEnum  : Model {

    case binaryType (Data)
    case booleanType (Bool)
    case dateType (Date)
    case decimalType (NSDecimalNumber)
    case doubleType (Double)
    case floatType (Float)
    case intType (Int)
    case stringType (String)
    case transformableColorType (UIColor)
    case decodableToManyType ([Employee])
    case decodableToOneType (Employee)

}

extension TestAssociatedEnum {

    public init?(with source: Store) {
        let store = TestAssociatedEnum.migrate(source: source)

        guard let type: String = store.value(forKey: "TestAssociatedEnum") else { return nil }
        switch type {
                case "binaryType":
                   if let value: Data = store.value(forKey: "value") {
                     self = TestAssociatedEnum.binaryType(value)
                   } else { return nil }

                case "booleanType":
                   if let value: Bool = store.value(forKey: "value") {
                     self = TestAssociatedEnum.booleanType(value)
                   } else { return nil }

                case "dateType":
                   if let value: Date = store.value(forKey: "value") {
                     self = TestAssociatedEnum.dateType(value)
                   } else { return nil }

                case "decimalType":
                   if let value: NSDecimalNumber = store.value(forKey: "value") {
                     self = TestAssociatedEnum.decimalType(value)
                   } else { return nil }

                case "doubleType":
                   if let value: Double = store.value(forKey: "value") {
                     self = TestAssociatedEnum.doubleType(value)
                   } else { return nil }

                case "floatType":
                   if let value: Float = store.value(forKey: "value") {
                     self = TestAssociatedEnum.floatType(value)
                   } else { return nil }

                case "intType":
                   if let value: Int = store.value(forKey: "value") {
                     self = TestAssociatedEnum.intType(value)
                   } else { return nil }

                case "stringType":
                   if let value: String = store.value(forKey: "value") {
                     self = TestAssociatedEnum.stringType(value)
                   } else { return nil }

                case "transformableColorType":
                   if let value: UIColor = store.value(forKey: "value") {
                     self = TestAssociatedEnum.transformableColorType(value)
                   } else { return nil }

                case "decodableToManyType":
                    if let value: [Employee] = store.value(forKey: "value") {
                        self = TestAssociatedEnum.decodableToManyType(value)
                    } else { return nil } 
                case "decodableToOneType":
                    if let value: Employee = store.value(forKey: "value") {
                        self = TestAssociatedEnum.decodableToOneType(value)
                    } else { return nil }

                default:
                    return nil
        }

    }

// MARK: - Storeable

    public static func restore(from store: Store) -> TestAssociatedEnum? {
        return self.init(with: store)
    }

    public func store(to store: inout Store) {

        switch self {
            case let .binaryType(value):
                store.set("binaryType", forKey: "TestAssociatedEnum")
                store.set(value, forKey: "value")
            case let .booleanType(value):
                store.set("booleanType", forKey: "TestAssociatedEnum")
                store.set(value, forKey: "value")
            case let .dateType(value):
                store.set("dateType", forKey: "TestAssociatedEnum")
                store.set(value, forKey: "value")
            case let .decimalType(value):
                store.set("decimalType", forKey: "TestAssociatedEnum")
                store.set(value, forKey: "value")
            case let .doubleType(value):
                store.set("doubleType", forKey: "TestAssociatedEnum")
                store.set(value, forKey: "value")
            case let .floatType(value):
                store.set("floatType", forKey: "TestAssociatedEnum")
                store.set(value, forKey: "value")
            case let .intType(value):
                store.set("intType", forKey: "TestAssociatedEnum")
                store.set(value, forKey: "value")
            case let .stringType(value):
                store.set("stringType", forKey: "TestAssociatedEnum")
                store.set(value, forKey: "value")
            case let .transformableColorType(value):
                store.set("transformableColorType", forKey: "TestAssociatedEnum")
                store.set(value, forKey: "value")
            case let .decodableToManyType(value):
                store.set("decodableToManyType", forKey: "TestAssociatedEnum")
                store.set(value, forKey: "value")
            case let .decodableToOneType(value):
                store.set("decodableToOneType", forKey: "TestAssociatedEnum")
                store.set(value, forKey: "value")

        }

            TestAssociatedEnum.writeVersion(to: &store)
            finishWriting(to: &store)
    }
}

